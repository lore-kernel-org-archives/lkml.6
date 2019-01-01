Return-Path: <SRS0=7Uv1=PJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCA39C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A50AE21019
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Jan 2019 20:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nisi.nl header.i=j.vlietland@nisi.nl header.b="W+yFhuaC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbfAAU7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 15:59:50 -0500
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21756 "EHLO
        sender-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfAAU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 15:59:50 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1546376377; cv=none; 
        d=zoho.com; s=zohoarc; 
        b=DMzwbnCKaFk2jBfUDUOjdUWM5yvFlyVRN/YDFFpIqgsvPhZRs56B0k9w+7s97NyZ/Jc8jiNJJKHEDUoruxNg9KgG8FCC7AaoXJUUHGNSr7jb1AUuoVzlXUAYJbW8so3zxaQq4Q7sFWDHVqFq/WUZARN3j1KM76A8FFlbIYqOTrM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com; s=zohoarc; 
        t=1546376377; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To:ARC-Authentication-Results; 
        bh=/wa1P2nzOIiS+TR5+a9OfcqeDrrCqEelQG53hc+Bw6c=; 
        b=OYaW6sZxrF/YJ13+vtg+oR7xeJcFMIGeRW1GY+JNQFK4Qul2Jp+XX1vMClWIpp8/pu0gT4v1ra7MpKVUhHciQbA27bb6jcwWZaSjL+knFnB32iiiRvDblb4U8I8KV0E1Gcjvzs3wVonTGltSpxbdx1GX6F7AcJ9hNze5L43gmj8=
ARC-Authentication-Results: i=1; mx.zoho.com;
        dkim=pass  header.i=nisi.nl;
        spf=pass  smtp.mailfrom=j.vlietland@nisi.nl;
        dmarc=pass header.from=<j.vlietland@nisi.nl> header.from=<j.vlietland@nisi.nl>
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zoho; d=nisi.nl; 
  h=to:cc:from:message-id:subject:date:user-agent:mime-version:content-type; 
  b=k2HRE43eD66NqxIrkJE73EIAfbGo0F9JXra/FnmabpOlrk7iWtuYOtY47t57ETdkB201POMP4G9n
    K3CFChWnPeYerKjLOEcnU5cfCFhF4CP0PqY4/LbPk6gVetvWzk8dqiYVW6dBZ57jAqoj3Vv7Bd+C
    9V24g8wA9PMUswws57Y=  
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1546376377;
        s=zoho; d=nisi.nl; i=j.vlietland@nisi.nl;
        h=To:Cc:From:Message-ID:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding;
        l=1621; bh=/wa1P2nzOIiS+TR5+a9OfcqeDrrCqEelQG53hc+Bw6c=;
        b=W+yFhuaCVOi+XZoevw/MdI0m5iaOkiZs1N/PiMOvSB56p1iscPsVU9AnlkvdwjB2
        5jSCu5rIm0gpXJ4oLCuGwhbDTe1XZgCOGwRgtrb96/NvpfUiTWxDaK1yIUGao7gWGyY
        aTxy2Gb1yXfA08kaUJrJuSagMcPRTEpKHkjIBN10=
Received: from [192.168.93.103] (5357467A.cm-6-8b.dynamic.ziggo.nl [83.87.70.122]) by mx.zohomail.com
        with SMTPS id 154637637522493.61114606156218; Tue, 1 Jan 2019 12:59:35 -0800 (PST)
To:     Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>
Cc:     "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
From:   Jan Vlietland <j.vlietland@nisi.nl>
Message-ID: <cb43e1cb-dffa-26d8-c938-49ca4b48d38a@nisi.nl>
Subject: Nouveau module results in total lockups without any dmesg trace on a
 NP900X5N Kaby Lake machine
Date:   Tue, 1 Jan 2019 21:59:02 +0100
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

Hi Ben, David and Daniel ,

First of all happy new year. Based on advice of Greg K-H herewith a mail=20
about a number of Nouveau issues with my laptop.

I installed various Kali linux versions up to Linux 4.20.0-rc7=20
(downloaded, compiled and installed) on a Samsung NP900X5N laptop and=20
have an issue with the driver after loading.

My configuration:

- i7 7500
- 16 gb / 256 gb ssd
- nvidia 940MX (for 3D graphics)

When I enable loading of the nouveau module for my Nvidia 3D card I get=20
three MMIO faults:

[   35.984104] nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 60=
13d4 [ IBUS ]
[   35.997510] nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 10=
ac08 [ IBUS ]
[   37.551790] nouveau 0000:01:00.0: bus: MMIO read of 00000000 FAULT at 61=
9444 [ IBUS ]

I see currenty varous discussions on bugzilla: (as summarized by Bruno=20
Pagani) https://bugs.freedesktop.org/show_bug.cgi?id=3D100423.

But I do not see any confirmed solutions on the MMIO faults.

The module is loaded but X server cannot run in framebuffer mode. I=20
assume that the module does not provide any video memory to X to run in=20
graphics mode.

First of all I would like to understand what the faults impose.
And I also would like to help you providing testing to fix the errors.

Many thanks for your kind support.


--=20

Met vriendelijke groet,

*dr. Jan Vlietland*, namens

spin-off

Nederlands Instituut voor de Software Industrie

_j.vlietland@nisi.nl_| 06 =E2=80=93 20 411 834 | 030 =E2=80=93 268 53 98
Princetonplein 5 | 3584 CC=C2=A0 Utrecht | www.nisi.nl



