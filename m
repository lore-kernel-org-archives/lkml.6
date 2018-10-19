Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD85ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A5C2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9A5C2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJTH6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:58:30 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:37186 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726604AbeJTH6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:58:30 -0400
Received: from mr2.cc.vt.edu (mr2.cc.vt.edu [IPv6:2607:b400:92:8400:0:90:e077:bf22])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id w9JNoGrH021444
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 19:50:16 -0400
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id w9JNoBA5020798
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 19:50:16 -0400
Received: by mail-vk1-f198.google.com with SMTP id n134so1464926vkc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Oct 2018 16:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=xyUdJ/Qfgkkbyiw00yv6LAIC9S00tI7PqHQcrZvtvWY=;
        b=Rx09PW/7SBktpkqUV4U13Rjt0TgpCdKdD84nLKkFJ7/K9Av+SORC5vvZeQ4sf/EgiD
         Ap7YYJvOuvVHSfyMxFXvbeROqKkIZ/c4rMkj6oAiOUbIe73OBOmQqb/3AprjTEXDKLBs
         6fUEujx8XF8pBGBZRzFbHtfbmFqE57CPTLZcFzxhmAjT1txvH0C79ALiG0HUE+RtrzPV
         Tg6XsuZ+ngdAlnJpMRhCOZZ2dZbWlcAvK+EdcXXaGUct0ibKAYghkALj7sQvOgfUzynb
         iAnE0t9Qa8bytZ+5PU4UcpFgGPHC/ahAmEg5jSVhLFsUBaNo8mrMJcioCaW35CiRMO5E
         cEGg==
X-Gm-Message-State: ABuFfojKpg1fLWgihNaGUm/ftlkeB9fjT0D/MJzP/zm/qt+9Wxl4bLgr
        UyjRdqkCTUvBPkiR5YYL9fS5PUuvJMiKc0j/GkiCdQiL9Y5IrJm4J8UbZSWQkWKqfOV7uunWDOE
        Fn4vNS9xlsDj5YESnYTrvgz8hqsNYQJQZfQ8=
X-Received: by 2002:a67:d595:: with SMTP id m21mr1243194vsj.139.1539993011197;
        Fri, 19 Oct 2018 16:50:11 -0700 (PDT)
X-Google-Smtp-Source: ACcGV60ZArgK7ZifPGSk3eNlHa0BYs+VNGy13VIrs+OUAhLWrbtggeqYxoyy0j/8BUoYyu4z77kX5Q==
X-Received: by 2002:a67:d595:: with SMTP id m21mr1243183vsj.139.1539993010689;
        Fri, 19 Oct 2018 16:50:10 -0700 (PDT)
Received: from turing-police.cc.vt.edu ([2601:5c0:c001:4340::be3])
        by smtp.gmail.com with ESMTPSA id v127-v6sm3011874vke.46.2018.10.19.16.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 19 Oct 2018 16:50:09 -0700 (PDT)
From:   valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To:     Dennis Zhou <dennis@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-Reply-To: <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
References: <13987.1539646128@turing-police.cc.vt.edu> <20181016160203.GA88193@dennisz-mbp.dhcp.thefacebook.com> <20181016182513.GA9886@dennisz-mbp.dhcp.thefacebook.com> <13448.1539791255@turing-police.cc.vt.edu>
 <20181017212029.GA85639@dennisz-mbp.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539993007_2536P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Fri, 19 Oct 2018 19:50:08 -0400
Message-ID: <3699.1539993008@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1539993007_2536P
Content-Type: text/plain; charset=us-ascii

On Wed, 17 Oct 2018 17:20:29 -0400, Dennis Zhou said:

> could apply that and send me the full dmesg that would be great. Lastly,
> can you just confirm for me that the commit before, f0fcb3ec89f3
> "blkcg: remove additional reference to the css", isn't seeing this
> issue?

Script started on 2018-10-19 18:53:41-04:00
[root@turing-police x86_64]# uname -a
Linux turing-police.cc.vt.edu 4.19.0-rc2-00202-gf0fcb3ec89f3 #640 SMP PREEMPT Fri Oct 19 14:20:22 EDT 2018 x86_64 x86_64 x86_64 GNU/Linux
[root@turing-police x86_64]# rpm -Uvh --force dracut-049-4.git20181010.fc30.x86_64.rpm
Verifying...                          ################################# [100%]
warning: Unable to get systemd shutdown inhibition lock: Failed to connect to socket /run/dbus/system_bus_socket: No such file or directory
Preparing...                          ################################# [100%]
Updating / installing...
   1:dracut-049-4.git20181010.fc30    ################################# [100%]
[root@turing-police x86_64]# exit
exit

Script done on 2018-10-19 18:54:09-04:00

That commit comes up "good" - broken kernels die before I ever get the prompt back...

--==_Exmh_1539993007_2536P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8ptr40DS38y7CIcAQIuegf/QtQ9PQOKoXVijewIucqhWzvzZWIRvWeb
A1JO8Eang9AUDjkX5FvSs6RW7veaViMJ+Mgt12FmCJkdJzJjxjcgQI1H1p0kIe3U
bQTmxEGBO7PpsasVyhIYsc2dDssgW5rjkTn3PHZzuua76WAq7y4cJq8TsDns1GgO
bfGlipvUKdlfu/hVt/YwlHWswIZm1acyQHtuYoFU1KGTE3/4ZFLzjxe6cw9vAKNS
3ZMMLsnEQQPdG9hrTrhkCM9hIybc1+uSWoHkrEYFygSZnWX/+cVZfoLSeu0eL9il
qh8TDKyh4ccwILfpvAWfo4W0fcOxVppHUei5Z/kpzKC+NUAnk2dsvg==
=l+JZ
-----END PGP SIGNATURE-----

--==_Exmh_1539993007_2536P--
