Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1742877-1523966696-2-2741372230468446330
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523966695; b=OmL2QIIRMIrH5oh10yidqmMgoN2VZaIADBIAZIrIx5hiwfqDTL
    1oyOotMH7uhkwuNokXRNKSChO4ET4lTMOmhdRCrgDwN+xLVRLy7mWerv24KiJYOi
    +F6Hi+frfjOSXHaj99hg2Ncn3olSshcKD7edYqA7AwKTgCYsc0iSW85Nzod6yjGB
    pkj6WkVmXsC+nr2Inu/zYbZzY0zdCW4GqA8Ax0Hbx/LbmnqccWLmurdcI+jv1yJx
    sq9amJzLuEJbL9fdXE/fVRN/cpyBey8esXdrXWoc6BX7StrkPbMsubn3QEejoWQU
    N9oC3iV1DxD9xNtem/gjJgd9JraSd8fD8fwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523966695; bh=U6kCZh6Iz78
    c+DWyr4wFDvOnJpzabbCE1XmPupWUp1I=; b=S6Zx9rP1npHfW6jb2NJ+QUheVz3
    RruffR6XA7FmUlsxaQRvheLTQDKDm1IMNAVyCKaSVsLmwKXjf6nyYVfKHHyeStZa
    y8clMIy0tL5f9HbaHisjg1Lobtcita3F8iTCIvwWiPNOGHfBI2WuVBympctp+w/6
    k+KeJLJHr4AKtfzv7fFco+hTIdVgYhW+J0TG4O/5OeqJFXrb2wkDLEr/BGHK434T
    T7AvfOROSMHGMd2L05K5L7gE7GUJvBEl7mganN4lc4FA1n7ucr5QpL5bdVkzrLeG
    EI3TKRkftVtfo3l04Wcg5wUhWkY6n0fakgk2xX/FF4JLkgBHjGigEeuJ4Ag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFShmqgENn6kvrq41XYZJw5z3yIvgCPWqaV5u9XVW/jJGQyJHGi6nkx8oVEaK5bkMo3Hd8RbL6jagklovjzjZC7lUlkxOJZiQTUw3hw58RYyTBt5+KOp
    0QR2W4guxJ3uiRC2dkcaSMFVbdZRNP5ZIl4qMJtZFGxqByd3rd0v2E0Ee8fNP/b5y6hBPLsOP2k6NgCYkeOP8NgKdzqfcY8/iyK1UKZplehzW8NnppYgn24e
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=D19gQVrFAAAA:8 a=iox4zFpeAAAA:8 a=q_sCZAb3pzt12nq7YxIA:9
    a=NXur57fvDm-fXyGk:21 a=5lCTmORruWll43K1:21 a=QEXdDO2ut3YA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752774AbeDQMEy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 08:04:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:39190 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752707AbeDQMEx (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 08:04:53 -0400
Date: Tue, 17 Apr 2018 14:04:51 +0200
From: Jan Kara <jack@suse.cz>
To: Pavlos Parissis <pavlos.parissis@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>,
        stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Subject: Re: kernel panics with 4.14.X versions
Message-ID: <20180417120451.xixjctt2a4kwvpc4@quack2.suse.cz>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz>
 <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <134eb955-fae7-9fd0-946e-787986509d7b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <134eb955-fae7-9fd0-946e-787986509d7b@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 13:18:46, Pavlos Parissis wrote:
> On 17/04/2018 01:31 πμ, Pavlos Parissis wrote:
> > On 16/04/2018 04:40 μμ, Jan Kara wrote:
> >> On Mon 16-04-18 15:25:50, Guillaume Morin wrote:
> >>> Fwiw, there have been already reports of similar soft lockups in
> >>> fsnotify() on 4.14: https://lkml.org/lkml/2018/3/2/1038
> >>>
> >>> We have also noticed similar softlockups with 4.14.22 here.
> >>
> >> Yeah.
> >>  
> >>> On 16 Apr 13:54, Pavlos Parissis wrote:
> >>>>
> >>>> Hi all,
> >>>>
> > 
> > [..snip..]
> > 
> >>>> [373782.361064] watchdog: BUG: soft lockup - CPU#24 stuck for 22s! [kube-apiserver:24261]
> >>>> [373782.378225] Modules linked in: binfmt_misc sctp_diag sctp dccp_diag dccp tcp_diag udp_diag
> >>>> inet_diag unix_diag cfg80211 rfkill dell_rbu 8021q garp mrp xfs libcrc32c loop x86_pkg_temp_thermal
> >>>> intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> >>>> pcbc aesni_intel vfat fat crypto_simd glue_helper cryptd intel_cstate intel_rapl_perf iTCO_wdt ses
> >>>> iTCO_vendor_support mxm_wmi ipmi_si dcdbas enclosure mei_me pcspkr ipmi_devintf lpc_ich sg mei
> >>>> ipmi_msghandler mfd_core shpchp wmi acpi_power_meter netconsole nfsd auth_rpcgss nfs_acl lockd grace
> >>>> sunrpc ip_tables ext4 mbcache jbd2 i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt
> >>>> fb_sys_fops sd_mod ttm crc32c_intel ahci libahci mlx5_core drm mlxfw mpt3sas ptp libata raid_class
> >>>> pps_core scsi_transport_sas
> >>>> [373782.516807]  dm_mirror dm_region_hash dm_log dm_mod dax
> >>>> [373782.531739] CPU: 24 PID: 24261 Comm: kube-apiserver Not tainted 4.14.32-1.el7.x86_64 #1
> >>>> [373782.549848] Hardware name: Dell Inc. PowerEdge R630/02C2CP, BIOS 2.4.3 01/17/2017
> >>>> [373782.567486] task: ffff882f66d28000 task.stack: ffffc9002120c000
> >>>> [373782.583441] RIP: 0010:fsnotify+0x197/0x510
> >>>> [373782.597319] RSP: 0018:ffffc9002120fdb8 EFLAGS: 00000286 ORIG_RAX: ffffffffffffff10
> >>>> [373782.615308] RAX: 0000000000000000 RBX: ffff882f9ec65c20 RCX: 0000000000000002
> >>>> [373782.632950] RDX: 0000000000028700 RSI: 0000000000000002 RDI: ffffffff8269a4e0
> >>>> [373782.650616] RBP: ffffc9002120fe98 R08: 0000000000000000 R09: 0000000000000000
> >>>> [373782.668287] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> >>>> [373782.685918] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> >>>> [373782.703302] FS:  000000c42009f090(0000) GS:ffff882fbf900000(0000) knlGS:0000000000000000
> >>>> [373782.721887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >>>> [373782.737741] CR2: 00007f82b6539244 CR3: 0000002f3de2a005 CR4: 00000000003606e0
> >>>> [373782.755247] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> >>>> [373782.772722] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> >>>> [373782.790043] Call Trace:
> >>>> [373782.802041]  vfs_write+0x151/0x1b0
> >>>> [373782.815081]  ? syscall_trace_enter+0x1cd/0x2b0
> >>>> [373782.829175]  SyS_write+0x55/0xc0
> >>>> [373782.841870]  do_syscall_64+0x79/0x1b0
> >>>> [373782.855073]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
> >>
> >> Can you please run RIP through ./scripts/faddr2line to see where exactly
> >> are we looping? I expect the loop iterating over marks to notify but better
> >> be sure.
> >>
> > 
> > I am very newbie on this and I tried with:
> >  ../repo/Linux/linux/scripts/faddr2line ./vmlinuz-4.14.32-1.el7.x86_64
> > 0010:fsnotify+0x197/0x510
> > readelf: Error: Not an ELF file - it has the wrong magic bytes at the start
> > size: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> > IMAGE_SCN_MEM_NOT_PAGED in section .bss
> > nm: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> > IMAGE_SCN_MEM_NOT_PAGED in section .bss
> > nm: ./vmlinuz-4.14.32-1.el7.x86_64: no symbols
> > size: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> > IMAGE_SCN_MEM_NOT_PAGED in section .bss
> > nm: ./vmlinuz-4.14.32-1.el7.x86_64: Warning: Ignoring section flag
> > IMAGE_SCN_MEM_NOT_PAGED in section .bss
> > nm: ./vmlinuz-4.14.32-1.el7.x86_64: no symbols
> > no match for 0010:fsnotify+0x197/0x510
> > 
> > Obviously, I am doing something very wrong.
> > 
> 
> I produced an uncompressed image(the error above caused by giving a
> compressed image to faddr2line) by compiling 4.14.32 with config which we
> have in production and now faddr2line reports:
> 
>  ../repo/Linux/linux/scripts/faddr2line ./vmlinux 0010:fsnotify+0x197/0x510
> no match for 0010:fsnotify+0x197/0x510
> 
> 
>  ../repo/Linux/linux/scripts/faddr2line ./vmlinux fsnotify+0x197/0x510
> 
> 
> 
> skipping fsnotify address at 0xffffffff8129baf7 due to size mismatch (0x510 != 0x520)
> no match for fsnotify+0x197/0x510
> 
> what am I doing wrong?

Apparently the compiler compiled that function slightly differently than
what you have in production. You need to have the original vmlinux file
from the machine which crashed to be able to use faddr2line.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
