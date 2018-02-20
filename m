Return-Path: <kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org>
X-Cyrus-Session-Id: sloti22d1t05-2058923-1519111619-2-10390419747440629905
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_NONE -0.0001,
  LANGUAGES ensk.us-ascii, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='96.67.55.147', Host='shelob.surriel.com', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519111618; b=Igct2s+qZOFBUQEkIc9J6SywKrYEhsYa8aiwwCC+IJKWNWw
    sjmPl4EPiKl9gg6cxIJaNQhjP3fu/MxbjoRr8cSOcJ0hPda4Amuu4ET04u19zQU0
    /bWm6Nf7CorUcTy/n4PHNyThxxxi4OaP/HaAABdPs9lqGDF9CQpbWi9+15Zqb31j
    /MR9LL1wJGBHiehkvLGZkQ8w4U8JbXPq6iB8opEqHp0mx37d1dD0z8wWUDXFUx4D
    aHCJ5MgNeDaxtPYj43uq53J7gU11VmvZEOH9Hmrj5Whkn4ltMKAJeYkxua0Mp+FB
    58tuAZfqTZ24uhxyC/6E4olnQe93M+2NLXxU5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:from:date:message-id:subject
    :to:list-id:list-unsubscribe:list-archive:list-post:list-help
    :list-subscribe:content-type:content-transfer-encoding; s=
    arctest; t=1519111618; bh=ApRIf0ILKu1gUPUigJaGXEVMiIUDf97I7w2Pat
    4dXbo=; b=sIse/Clmt90h4UgvngiSKHMZoF2h4epsKtZx3g30EKEsdDD5KDy4cQ
    DYCMjIRTPJdIIRnu3fK89UxhrvOh0ayvH355QlQzyXriCz8hnCtZgxbYACdBIPmL
    0oQwERDKyGxXXYo/1SE+henEMwm5d92Xg4BfXFSEK/qPSLeYCCpJFpIVpuMw3tBh
    fVaAxLJ3wENE3MluxIKTXnYp6HT+/T7Ljj6Lk2vo52yDXEhx1fHdQ+trJVFJSuDX
    te+O/D9OCL/o86hvVYk/ueyI8OVnSvN1UxsF05A1wIg7OOuljj5RbvxyWC/Im/RA
    VIahop4NfWPMQdyFUf4DGsssc7kLHZlQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Eny9H5L6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Baphicjn;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Eny9H5L6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=96.67.55.147 (shelob.surriel.com);
    spf=permerror smtp.mailfrom=kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org smtp.helo=shelob.surriel.com;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Baphicjn;
    x-ptr=pass x-ptr-helo=shelob.surriel.com x-ptr-lookup=shelob.surriel.com;
    x-return-mx=pass smtp.domain=kernelnewbies.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AH8x227K8aVOnO7BV31tBYqyLeOlW/m3N+fbvgG4Zc6UXhuzFWuXEvrneaTb4WOoXim4xOTT+SblYUt/rdH2IYyje+k=
MIME-Version: 1.0
From: Ivid Suvarna <ivid.suvarna@gmail.com>
Date: Tue, 20 Feb 2018 12:53:26 +0530
Message-ID: <CABXF_AAQVJ7eMt4gFhiEcgZTD7Y4R66-9ELZ1OJ2gAmKPeLMAw@mail.gmail.com>
Subject: Timekeeping warning during resume from suspend to disk
To: Kernel development list <linux-kernel@vger.kernel.org>,
 kernelnewbies@kernelnewbies.org, Linux-pm@vger.kernel.org
X-BeenThere: kernelnewbies@kernelnewbies.org
X-Mailman-Version: 2.1.15
List-Unsubscribe: <https://lists.kernelnewbies.org/mailman/options/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=unsubscribe>
List-Archive: <http://lists.kernelnewbies.org/pipermail/kernelnewbies/>
List-Post: <mailto:kernelnewbies@kernelnewbies.org>
List-Help: <mailto:kernelnewbies-request@kernelnewbies.org?subject=help>
List-Subscribe: <https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies>,
 <mailto:kernelnewbies-request@kernelnewbies.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: kernelnewbies-bounces+greg=kroah.com@kernelnewbies.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi All,

Facing below warning backtrace during resume from suspend to disk. I
am using 4.1.15 freescale kernel. After this warning there is a huge
time gap (nearly 10 sec) between Enabling non-boot cpus and CPU1 being
up. Any pointers on this would be helpful.

[  545.227081] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  545.227081] [<80018674>] (unwind_backtrace) from [<80013c24>]
(show_stack+0x20/0x24)
[  545.227081] [<80013c24>] (show_stack) from [<80684220>]
(dump_stack+0x7c/0xbc)
[  545.227081] [<80684220>] (dump_stack) from [<80034fcc>]
(warn_slowpath_common+0x94/0xc4)
[  545.227081] [<80034fcc>] (warn_slowpath_common) from [<800350b8>]
(warn_slowpath_null+0x2c/0x34)
[  545.227081] [<800350b8>] (warn_slowpath_null) from [<8009ce24>]
(clockevents_program_event+0x14c/0x15c)
[  545.227081] [<8009ce24>] (clockevents_program_event) from
[<8009f39c>] (tick_resume_oneshot+0x5c/0x64)
[  545.227081] [<8009f39c>] (tick_resume_oneshot) from [<8009daa8>]
(tick_resume_local+0x58/0x68)
[  545.227081] [<8009daa8>] (tick_resume_local) from [<8009daf4>]
(tick_resume+0x1c/0x20)
[  545.227081] [<8009daf4>] (tick_resume) from [<80096328>]
(timekeeping_resume+0x1c8/0x2bc)
[  545.227081] [<80096328>] (timekeeping_resume) from [<803e5a7c>]
(syscore_resume+0x94/0x250)
[  545.227081] [<803e5a7c>] (syscore_resume) from [<800721b0>]
(suspend_devices_and_enter+0x78c/0x99c)
[  545.227081] [<800721b0>] (suspend_devices_and_enter) from
[<800728a0>] (pm_suspend+0x4e0/0x74c)
[  545.227081] [<800728a0>] (pm_suspend) from [<80070adc>]
(state_store+0x74/0xa0)
[  545.227081] [<80070adc>] (state_store) from [<8031f3c4>]
(kobj_attr_store+0x1c/0x28)
[  545.227081] [<8031f3c4>] (kobj_attr_store) from [<801a9814>]
(sysfs_kf_write+0x50/0x54)
[  545.227081] [<801a9814>] (sysfs_kf_write) from [<801a8fc8>]
(kernfs_fop_write+0xcc/0x1b8)
[  545.227081] [<801a8fc8>] (kernfs_fop_write) from [<8013c1d4>]
(__vfs_write+0x3c/0xec)
[  545.227081] [<8013c1d4>] (__vfs_write) from [<8013ca88>]
(vfs_write+0xa0/0x180)
[  545.227081] [<8013ca88>] (vfs_write) from [<8013d2fc>] (SyS_write+0x4c/0xa0)
[  545.227081] [<8013d2fc>] (SyS_write) from [<8000fd3c>]
(__cpuset_migrate_return+0x0/0x24)

Regards,
IVID

_______________________________________________
Kernelnewbies mailing list
Kernelnewbies@kernelnewbies.org
https://lists.kernelnewbies.org/mailman/listinfo/kernelnewbies
