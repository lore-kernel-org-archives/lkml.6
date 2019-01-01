Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60432C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE46F2073F
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 17:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nisi.nl header.i=j.vlietland@nisi.nl header.b="kaer1K8H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfAARMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 12:12:08 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21734 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbfAARMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 12:12:08 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546362716; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=MYBLypVYGqGBQJZBxOhXtsjtx8K/PKnzONIerfT+d/UfkoPR83s2DjwN1MJ+aWkhpGyrDg5ig6Fvxh4vCE8U844R9PQ3dJims4sjSlHNRZO6F9O2VC8zZsJl3ncA8F+3Z4r4580F73wDPtK6I/ycnbIkc+guaXiHLRN50X6rUoc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546362716; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=Q1eY8SCogyt/ElYj0kgYv6hKMnXPWvrjKH9L+ZV4CiE=; 
        b=ZHendpdtCQTK18UQK50DjduwFYMZEplryz+tSLw0yvFTXKr8eoSRlGtOPG4P6iQtjTiMWIaF+w+0Bm9EYhFifLCFGSO1kbIB2URv2GB68fNdBMVrfgoPvM7AozIcIpH3SgjgNxyoKrJwg/6VwmwOj9G3FZHNG1f79DxFP2P2NI0=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=nisi.nl;
        spf=pass  smtp.mailfrom=j.vlietland@nisi.nl;
        dmarc=pass header.from=<j.vlietland@nisi.nl> header.from=<j.vlietland@nisi.nl>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=nisi.nl; 
  h=to:from:subject:cc:message-id:date:user-agent:mime-version:content-type; 
  b=OLgGo0QxuTmyBXROhDuxYcojR3g7LZzkGuLtRjvbg62ePagoPgBCtg9T8zVmE5xIl3c4y7O9TOuD
    Qe61/V8Sqo/OQbPLzCi21i9DJLwEFcz9PfqnKgDyuJRs0qUKxPDhBNxQN43ogaZAqm8eqtuzGrEZ
    CfANL5OHEXjBqI0xeso=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546362716;
        s=zoho; d=nisi.nl; i=j.vlietland@nisi.nl;
        h=To:From:Subject:Cc:Message-ID:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=2271; bh=Q1eY8SCogyt/ElYj0kgYv6hKMnXPWvrjKH9L+ZV4CiE=;
        b=kaer1K8HHgYZplRfYF91SDYeiJJ0AyjTa8/wb/NpYj91CQQlpXRic4Xz4PwLwpmQ
        qa2OFTPpVk5SILT8EeKKSWG6RvqolLTXg6+0Dhet2LMJzOfki/UE9u+cJ8IvR+Bvqo8
        2Qo+hlZnRARcnNYwXRXic5mWSffXlvSzGnEte0y4=
Received: from [192.168.93.103] (5357467A.cm-6-8b.dynamic.ziggo.nl [83.87.70.122]) by mx.zohomail.com
        with SMTPS id 1546362714011891.1093809139968; Tue, 1 Jan 2019 09:11:54 -0800 (PST)
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        "Moorestow...),Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>,
        "Moorestow...),Rodrigo Vivi" <rodrigo.vivi@intel.com>,
        "Moorestow...),David Airlie" <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org
From:   Jan Vlietland <j.vlietland@nisi.nl>
Subject: i915 module results in total lockups without any dmesg trace on a
 NP900X5N Kaby Lake machine
Cc:     open list <linux-kernel@vger.kernel.org>
Message-ID: <fb45fc15-1623-6f7e-e1a8-ef7f09fa7deb@nisi.nl>
Date:   Tue, 1 Jan 2019 18:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: nl
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

First of all happy new year. Based on advice of Greg K-H herewith a mail=20
about my continuous (frustrating) issue with my laptop.

I installed various Kali linux versions up to Linux 4.20.0-rc7=20
(downloaded, compiled and installed) on a Samsung NP900X5N laptop and=20
have an issue with the driver after loading.

My configuration:

- i7 7500
- 16 gb / 256 gb ssd
- nvidia 940MX (for 3D graphics)

Shortly after loading the module the screen goes black (af if screen=20
saver) and stays black. I tried to fix it myself.and 'studied' the=20
behaviour for about 20 hours, I think it is a bug in the i915 module=20
itself. I consider it much more efficient to ask you guys for some help.

A summary of the test I performed.

- I tried several versions and distributions (about 7). They all result=20
in the same behaviour. Screen goes black.I do not see any logging in=20
the=C2=A0 logs. I enabled ssh and the machine is unresponsive after the=20
screen going black. The more tests I do (rebooting via holding power=20
key) the sooner the screen goes black. I wonder if the gpu gets too hot=20
locally. Btw, the processor is not hot as the fan stays off.

- I tried changing various parameters in the i915 module. No luck. For=20
example, no compression, no power reduction.

- Guc/huc setting to 0x03 seems to delay the black screens but the black=20
screens continue.

- When I disable the driver in grub or in the modprobe.d dir I do not=20
have any black screens.

- After closing and opening the lid the machine does not wake up.

- With Windows 10 the machine does not results in lockups (kept the=20
machine on for more than 24 hours).

I would really appreciate some help here because the machine is unusable=20
with Linux. Furthermore my older NP900X4D is working with Linux for=20
almost 5 years now. I love linux and rather throw the machine away than=20
using Windows 10 :-)

ps: my Nouveau gives MMIO Faults so is not usable as well.

--=20

Met vriendelijke groet,

*dr. Jan Vlietland*, namens

spin-off

Nederlands Instituut voor de Software Industrie

_j.vlietland@nisi.nl_| 06 =E2=80=93 20 411 834 | 030 =E2=80=93 268 53 98
Princetonplein 5 | 3584 CC=C2=A0 Utrecht | www.nisi.nl



