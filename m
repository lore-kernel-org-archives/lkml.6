Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB27C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D55D9208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ff3s6auo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D55D9208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933087AbeGHXqe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:46:34 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34133 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754397AbeGHXqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:46:33 -0400
Received: by mail-pl0-f66.google.com with SMTP id z9-v6so5151034plo.1;
        Sun, 08 Jul 2018 16:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gjd5ouBSMX8mvVhPc8efQ7RaEOBs5tcE49ezi3kIBjs=;
        b=Ff3s6auoaUoC0SKEBoPs/ZrPG//OmsdAnPf02ih+LaCGkdKxgyst94AEz9et9tCi37
         j8uDuxxotsg6cTPrKikNfhp1VvK+z3nsVQTMHPD1pTFp7OoxUBBL41KscES5cPz+wuuG
         9axUAKA5fiI7fNK7Dp9oqI7Qqd/aUMJeFGE8RJU0E9QscUuPPqlr7KMBwCukWE8IFdPS
         bv8bdejnqm6jFkjL3pJ9flKJaTHU/aYZEOU0KQPcjKiWwWC+AsmbZfu5q8rcxauoQ1SP
         1+b8VIln8HZUVCjZNk0s4HgrBr4md+4YruQTFL+I/Y0R+08XJMFJm99aCLfM+Gskleb7
         FuDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gjd5ouBSMX8mvVhPc8efQ7RaEOBs5tcE49ezi3kIBjs=;
        b=LvFRMQtImXq/7ecSqcmHsTvFLUAO4ueSaYuDuorKCu+TNJHY1FUvJPyjyoizWs74CB
         WKhG4xK7AeSJJgW95IleKVAUjW53cg2tDwLliHGW+AcDGoezOvagNi5lthifoMaJza2k
         FkSX9BWZsiT0QWAWRzwnGJD5lGl2OgDkn3N47owTOXs6HpkypLD3AqLx8b0wBhKLXMAV
         tGsPXGvwjclTLKrqOgawuhaeEFBzDxOtZU/QDoqEsgVQbgD3PSXtAanlEiQ+aWlVml+c
         eK6HR1lJ0adB7NgZV5KI+ZNbmQB4C2bghwjCH3C246JO+asZkUd115TqGYXTWG8am1uG
         XKjQ==
X-Gm-Message-State: APt69E1FWrdNaJKaTMmLispqZWC8SMiJrPVDSpEA72IRwHff3L9b5CTc
        KH6YNsBQo2cXKPpfC2fASYA=
X-Google-Smtp-Source: AAOMgpcbNxBsMzUPOrVtPNME4vggERjFhy0xzaRIO7p/yHE2+RulSVImgMraEd/86mjgwVzneUZC9w==
X-Received: by 2002:a17:902:321:: with SMTP id 30-v6mr18740334pld.122.1531093592393;
        Sun, 08 Jul 2018 16:46:32 -0700 (PDT)
Received: from sol.localdomain (c-67-185-97-198.hsd1.wa.comcast.net. [67.185.97.198])
        by smtp.gmail.com with ESMTPSA id r28-v6sm2939523pfd.37.2018.07.08.16.46.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 08 Jul 2018 16:46:31 -0700 (PDT)
Date:   Sun, 8 Jul 2018 16:46:30 -0700
From:   Eric Biggers <ebiggers3@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH vfs/for-next 00/18] fs_context fixes
Message-ID: <20180708234630.GB700@sol.localdomain>
References: <20180708210154.10423-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180708210154.10423-1-ebiggers3@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2018 at 02:01:36PM -0700, Eric Biggers wrote:
> Hi David and Al, here are some fixes for the fs_context patches.
> 
> Feel free to fold these into the original patches if you want.
> 
> Patches 13-18 are cleanups only.
> 

Also, mount(..., MS_REMOUNT|MS_BIND, ...) now validates the mount options
string, which breaks systemd unit files with ProtectControlGroups=yes (e.g.
systemd-networkd.service) when systemd does the following to change a cgroup
(v1) mount to read-only:

    mount(NULL, "/run/systemd/unit-root/sys/fs/cgroup/systemd", NULL, MS_RDONLY|MS_NOSUID|MS_NODEV|MS_NOEXEC|MS_REMOUNT|MS_BIND, NULL)

... when the kernel has CONFIG_CGROUPS=y but no cgroup subsystems enabled, since
in that case the error "cgroup1: Need name or subsystem set" is hit when the
mount options string is empty.

Probably it doesn't make sense to validate the mount options string at all in
the MS_REMOUNT|MS_BIND case, though maybe you had something else in mind.

- Eric
