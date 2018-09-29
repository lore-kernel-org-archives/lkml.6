Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059E9C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14F121471
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 14:26:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="bCPEp/eB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14F121471
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbeI2Uyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 16:54:37 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35106 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbeI2Uyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 16:54:37 -0400
Received: by mail-pg1-f193.google.com with SMTP id v133-v6so6473129pgb.2
        for <linux-kernel@vger.kernel.org>; Sat, 29 Sep 2018 07:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JoURWbeCzheI/EXJ35r9ZJfZ5dX4CS0+xhSGJpwfsWE=;
        b=bCPEp/eBRO2UuweSpjJggdh+R+hrTMN9vREziJBimjVHPCz3iuwcDtjX4f77KKLw0z
         tLDVXlhWt0BVE0MrW48wLQjN1ve2C9EsBbz3TIXGkZF0J+QkWbON8Q8zodGqW/8CYbL5
         0oV60BWgnXf1h99zmUtab64f5AXe33cWK4RHsjsZOogiLX0YYs2kGwOll2vrTJ0X1Sjx
         1qlNcheQnm9/OVmzLl/1R7AfNQnzv1xM/WmzXpmlgA1Blv0wwbUiUNUKXrx6OMrD2JM1
         hMy8MLj22QqXLBi35RrMhQfeY7+XXcCIpQXSZNppl057/lBzblZFH+EZGR9QaQ/NAkaN
         jnRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JoURWbeCzheI/EXJ35r9ZJfZ5dX4CS0+xhSGJpwfsWE=;
        b=XPvUC7KLTSg3Sq/IsNmqK/xMDo+oe2pn1udsPk1NkwWz+0yG1/QquZ6BKB28Np8b56
         yWQpgsWN0FtzTCFulvEba48p4vvnmInR/WhW7zx6VOvxwOQDsB15pUM4TxHyEnQ6ogf8
         K5OVAe+Mn908RGJt8Zmquyr8hW93ETtQ27QjjtEAiuvTMPpJjggNJ8LuM+jHGpL40zMG
         bz/EH239Lz035zRqnDBsy0+juJUpe15BK+nEHMev0wAt6do1z7mo7hea5HNtveIrqf3w
         5v6FSI71H8oxyuFNJuL5e6Jn6CwfUlPVctdJlrx7vvYJDnZE4yMsbt2RilBmOH4h4GVB
         rieA==
X-Gm-Message-State: ABuFfogr1s2asK+LLJg+NLvowMlCzRD+RyOPQZncfHPzvPze6H9r8R3J
        tGGgdLcrk+tfNv13JVTT25CXA2I4Bng=
X-Google-Smtp-Source: ACcGV60whuuS9gywW8NQUojHf8bzAtjeZFWZ7JOUexPX5F+c930vcpgPrmUmD/jcKhVG+N87t9eyzA==
X-Received: by 2002:a63:5860:: with SMTP id i32-v6mr3185698pgm.178.1538231159113;
        Sat, 29 Sep 2018 07:25:59 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:81d2:c733:112:8bd0? ([2601:646:c200:7429:81d2:c733:112:8bd0])
        by smtp.gmail.com with ESMTPSA id 22-v6sm12557468pfl.126.2018.09.29.07.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 07:25:58 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 0/3] namei: implement various scoping AT_* flags
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (16A366)
In-Reply-To: <20180929103453.12025-1-cyphar@cyphar.com>
Date:   Sat, 29 Sep 2018 07:25:57 -0700
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Eric Biederman <ebiederm@xmission.com>,
        Tycho Andersen <tycho@tycho.ws>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, dev@opencontainers.org,
        containers@lists.linux-foundation.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1EE20CA2-4C8B-4A80-B613-0277D92B376D@amacapital.net>
References: <20180929103453.12025-1-cyphar@cyphar.com>
To:     Aleksa Sarai <cyphar@cyphar.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 29, 2018, at 3:34 AM, Aleksa Sarai <cyphar@cyphar.com> wrote:
>=20
> The need for some sort of control over VFS's path resolution (to avoid
> malicious paths resulting in inadvertent breakouts) has been a very
> long-standing desire of many userspace applications. This patchset is a
> revival of Al Viro's old AT_NO_JUMPS[1] patchset with a few additions.
>=20
> The most obvious change is that AT_NO_JUMPS has been split as dicussed
> in the original thread, along with a further split of AT_NO_PROCLINKS
> which means that each individual property of AT_NO_JUMPS is now a
> separate flag:
>=20
>  * Path-based escapes from the starting-point using "/" or ".." are
>    blocked by AT_BENEATH.

Seems useful.

>  * Mountpoint crossings are blocked by AT_XDEV.

Seems useful.

>  * /proc/$pid/fd/$fd resolution is blocked by AT_NO_PROCLINKS (more
>    correctly it actually blocks any user of nd_jump_link() because it
>    allows out-of-VFS path resolution manipulation).
>=20

So how do I disable following symlinks? ISTM the most natural way would be t=
o have AT_NO_SYMLINKS, and to have that flag disable proc links.=
