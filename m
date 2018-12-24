Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E233C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43D7F21908
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 12:13:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725808AbeLXMNF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 07:13:05 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725298AbeLXMNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 07:13:04 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id wBOBwVjD040248
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:13:01 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2pjx2gam9n-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 24 Dec 2018 07:13:01 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Mon, 24 Dec 2018 12:12:58 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 24 Dec 2018 12:12:55 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id wBOCCsJl57016430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Dec 2018 12:12:54 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3CD68A4062;
        Mon, 24 Dec 2018 12:12:54 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D636A4054;
        Mon, 24 Dec 2018 12:12:53 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon, 24 Dec 2018 12:12:53 +0000 (GMT)
Date:   Mon, 24 Dec 2018 14:12:51 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Paul Oppenheimer <bepvte@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>, Jan Kara <jack@suse.cz>,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug with report THP eligibility for each vma
References: <CALouPAi8KEuPw_Ly5W=MkYi8Yw3J6vr8mVezYaxxVyKCxH1x_g@mail.gmail.com>
 <20181224074916.GB9063@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20181224074916.GB9063@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 18122412-0028-0000-0000-0000032EC65E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18122412-0029-0000-0000-000023EB387E
Message-Id: <20181224121250.GA2070@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-24_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812240108
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 08:49:16AM +0100, Michal Hocko wrote:
> [Cc-ing mailing list and people involved in the original patch]
> 
> On Fri 21-12-18 13:42:24, Paul Oppenheimer wrote:
> > Hello! I've never reported a kernel bug before, and since its on the
> > "next" tree I was told to email the author of the relevant commit.
> > Please redirect me to the correct place if I've made a mistake.
> > 
> > When opening firefox or chrome, and using it for a good 7 seconds, it
> > hangs in "uninterruptible sleep" and I recieve a "BUG" in dmesg. This
> > doesn't occur when reverting this commit:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=48cf516f8c.
> > Ive attached the output of decode_stacktrace.sh and the relevant dmesg
> > log to this email.
> > 
> > Thanks
> 
> > BUG: unable to handle kernel NULL pointer dereference at 00000000000000e8
> 
> Thanks for the bug report! This is offset 232 and that matches
> file->f_mapping as per pahole
> pahole -C file ./vmlinux | grep f_mapping
>         struct address_space *     f_mapping;            /*   232     8 */
> 
> I thought that each file really has to have a mapping. But the following
> should heal the issue and add an extra care.
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f64733c23067..fc9d70a9fbd1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -66,6 +66,8 @@ bool transparent_hugepage_enabled(struct vm_area_struct *vma)
>  {
>  	if (vma_is_anonymous(vma))
>  		return __transparent_hugepage_enabled(vma);
> +	if (!vma->vm_file || !vma->vm_file->f_mapping)
> +		return false;
>  	if (shmem_mapping(vma->vm_file->f_mapping) && shmem_huge_enabled(vma))
>  		return __transparent_hugepage_enabled(vma);

We have vma_is_shmem(), it can be used to replace shmem_mapping() without
adding the check for !vma->vm_file

>  
> Andrew, could you fold it to the original patch please?
> 
> Keeping the rest for the reference.
> 
> > #PF error: [normal kernel read fault]
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 7 PID: 2687 Comm: StreamTrans #56 Tainted: G     U            4.20.0-rc7-next-20181221-beppy+ #15
> > Hardware name: Dell Inc. XPS 13 9360/0TPN17, BIOS 2.10.0 09/27/2018
> > RIP: 0010:transparent_hugepage_enabled (??:?) 
> > Code: 17 fd 00 e9 20 ff ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 89 fb 48 83 bf 90 00 00 00 00 74 27 48 8b 87 a0 00 00 00 <48> 8b b8 e8 00 00 00 e8 7a cc fa ff 84 c0 75 04 31 c0 5b c3 48 89
> > All code
> > ========
> >    0:	17                   	(bad)  
> >    1:	fd                   	std    
> >    2:	00 e9                	add    %ch,%cl
> >    4:	20 ff                	and    %bh,%bh
> >    6:	ff                   	(bad)  
> >    7:	ff 0f                	decl   (%rdi)
> >    9:	1f                   	(bad)  
> >    a:	84 00                	test   %al,(%rax)
> >    c:	00 00                	add    %al,(%rax)
> >    e:	00 00                	add    %al,(%rax)
> >   10:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
> >   15:	53                   	push   %rbx
> >   16:	48 89 fb             	mov    %rdi,%rbx
> >   19:	48 83 bf 90 00 00 00 	cmpq   $0x0,0x90(%rdi)
> >   20:	00 
> >   21:	74 27                	je     0x4a
> >   23:	48 8b 87 a0 00 00 00 	mov    0xa0(%rdi),%rax
> >   2a:*	48 8b b8 e8 00 00 00 	mov    0xe8(%rax),%rdi		<-- trapping instruction
> >   31:	e8 7a cc fa ff       	callq  0xfffffffffffaccb0
> >   36:	84 c0                	test   %al,%al
> >   38:	75 04                	jne    0x3e
> >   3a:	31 c0                	xor    %eax,%eax
> >   3c:	5b                   	pop    %rbx
> >   3d:	c3                   	retq   
> >   3e:	48                   	rex.W
> >   3f:	89                   	.byte 0x89
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	48 8b b8 e8 00 00 00 	mov    0xe8(%rax),%rdi
> >    7:	e8 7a cc fa ff       	callq  0xfffffffffffacc86
> >    c:	84 c0                	test   %al,%al
> >    e:	75 04                	jne    0x14
> >   10:	31 c0                	xor    %eax,%eax
> >   12:	5b                   	pop    %rbx
> >   13:	c3                   	retq   
> >   14:	48                   	rex.W
> >   15:	89                   	.byte 0x89
> > RSP: 0018:ffffb79744f17d28 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8948c17aff00 RCX: 0000000000000000
> > RDX: 0000000000000004 RSI: ffffffffab1165ba RDI: ffff8948c17aff00
> > RBP: ffff8948c17aff00 R08: 0000000000000007 R09: ffff894927e547b2
> > R10: 0000000000000000 R11: ffff894927e549da R12: ffffb79744f17d38
> > R13: ffff8948c17aff00 R14: ffff89489bef9400 R15: ffff89488b775a80
> > FS:  00007fa54ad43700(0000) GS:ffff8949363c0000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000000e8 CR3: 000000025c0ee003 CR4: 00000000003606e0
> > Call Trace:
> > show_smap (/home/bep/.opt/kernel/linux-e/fs/proc/task_mmu.c:805) 
> > seq_read (/home/bep/.opt/kernel/linux-e/fs/seq_file.c:269) 
> > __vfs_read (/home/bep/.opt/kernel/linux-e/fs/read_write.c:421) 
> > vfs_read (/home/bep/.opt/kernel/linux-e/fs/read_write.c:452 /home/bep/.opt/kernel/linux-e/fs/read_write.c:437) 
> > ksys_read (/home/bep/.opt/kernel/linux-e/fs/read_write.c:579) 
> > do_syscall_64 (/home/bep/.opt/kernel/linux-e/arch/x86/entry/common.c:290) 
> > entry_SYSCALL_64_after_hwframe (/home/bep/.opt/kernel/linux/arch/x86/entry/entry_64.S:184) 
> > RIP: 0033:0x7fa585fb3184
> > Code: c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 5b fc ff ff 4c 89 e2 48 89 ee 89 df 41 89 c0 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 97 fc ff ff 48
> > All code
> > ========
> >    0:	c3                   	retq   
> >    1:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
> >    6:	41 54                	push   %r12
> >    8:	49 89 d4             	mov    %rdx,%r12
> >    b:	55                   	push   %rbp
> >    c:	48 89 f5             	mov    %rsi,%rbp
> >    f:	53                   	push   %rbx
> >   10:	89 fb                	mov    %edi,%ebx
> >   12:	48 83 ec 10          	sub    $0x10,%rsp
> >   16:	e8 5b fc ff ff       	callq  0xfffffffffffffc76
> >   1b:	4c 89 e2             	mov    %r12,%rdx
> >   1e:	48 89 ee             	mov    %rbp,%rsi
> >   21:	89 df                	mov    %ebx,%edi
> >   23:	41 89 c0             	mov    %eax,%r8d
> >   26:	31 c0                	xor    %eax,%eax
> >   28:	0f 05                	syscall 
> >   2a:*	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax		<-- trapping instruction
> >   30:	77 38                	ja     0x6a
> >   32:	44 89 c7             	mov    %r8d,%edi
> >   35:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
> >   3a:	e8 97 fc ff ff       	callq  0xfffffffffffffcd6
> >   3f:	48                   	rex.W
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	48 3d 00 f0 ff ff    	cmp    $0xfffffffffffff000,%rax
> >    6:	77 38                	ja     0x40
> >    8:	44 89 c7             	mov    %r8d,%edi
> >    b:	48 89 44 24 08       	mov    %rax,0x8(%rsp)
> >   10:	e8 97 fc ff ff       	callq  0xfffffffffffffcac
> >   15:	48                   	rex.W
> > RSP: 002b:00007fa54ad42060 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > RAX: ffffffffffffffda RBX: 000000000000002c RCX: 00007fa585fb3184
> > RDX: 0000000000001fff RSI: 00007fa54ffb2000 RDI: 000000000000002c
> > RBP: 00007fa54ffb2000 R08: 0000000000000000 R09: 000000000000001e
> > R10: 00007fa585c0dae0 R11: 0000000000000246 R12: 0000000000001fff
> > R13: 00007fa54ad42510 R14: 00007fa54ffb2fc5 R15: 00007fa54ad42498
> > Modules linked in: thunderbolt sch_cake rfcomm fuse arc4 iwlmvm mac80211 btusb btrtl btbcm btintel bnep bluetooth iwlwifi snd_hda_codec_hdmi ecdh_generic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel cfg80211 snd_hda_codec nf_log_ipv6 ip6t_REJECT nf_reject_ipv6 snd_hwdep xt_hl snd_hda_core ip6t_rt nf_log_ipv4 nf_log_common joydev snd_pcm mousedev ipt_REJECT nf_reject_ipv4 hid_multitouch intel_rapl xt_LOG xt_comment nls_iso8859_1 intel_pmc_core nls_cp437 intel_powerclamp xt_limit kvm_intel xt_addrtype xt_tcpudp dell_laptop snd_timer xt_conntrack ledtrig_audio snd dell_wmi nf_conntrack efi_pstore dell_smbios mei_me dcdbas input_leds idma64 mei wmi_bmof intel_wmi_thunderbolt dell_wmi_descriptor efivars rfkill intel_pch_thermal intel_lpss_pci processor_thermal_device i2c_i801 soundcore intel_lpss intel_soc_dts_iosf i2c_hid evdev int3403_thermal int3400_thermal intel_vbtn rtc_cmos int340x_thermal_zone acpi_thermal_rel intel_hid mac_hid nf_defrag_ipv6 nf_defrag_ipv4
> > ip6table_filter ip6_tables iptable_filter bpfilter coretemp msr dell_smm_hwmon crypto_user ip_tables x_tables algif_skcipher af_alg rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul xhci_pci ghash_clmulni_intel serio_raw rtsx_pci xhci_hcd i915 kvmgt vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass intel_gtt
> > CR2: 00000000000000e8
> > ---[ end trace 77d24d35c4e5213f ]---
> > RIP: 0010:transparent_hugepage_enabled (??:?) 
> > Code: 17 fd 00 e9 20 ff ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 89 fb 48 83 bf 90 00 00 00 00 74 27 48 8b 87 a0 00 00 00 <48> 8b b8 e8 00 00 00 e8 7a cc fa ff 84 c0 75 04 31 c0 5b c3 48 89
> > All code
> > ========
> >    0:	17                   	(bad)  
> >    1:	fd                   	std    
> >    2:	00 e9                	add    %ch,%cl
> >    4:	20 ff                	and    %bh,%bh
> >    6:	ff                   	(bad)  
> >    7:	ff 0f                	decl   (%rdi)
> >    9:	1f                   	(bad)  
> >    a:	84 00                	test   %al,(%rax)
> >    c:	00 00                	add    %al,(%rax)
> >    e:	00 00                	add    %al,(%rax)
> >   10:	0f 1f 44 00 00       	nopl   0x0(%rax,%rax,1)
> >   15:	53                   	push   %rbx
> >   16:	48 89 fb             	mov    %rdi,%rbx
> >   19:	48 83 bf 90 00 00 00 	cmpq   $0x0,0x90(%rdi)
> >   20:	00 
> >   21:	74 27                	je     0x4a
> >   23:	48 8b 87 a0 00 00 00 	mov    0xa0(%rdi),%rax
> >   2a:*	48 8b b8 e8 00 00 00 	mov    0xe8(%rax),%rdi		<-- trapping instruction
> >   31:	e8 7a cc fa ff       	callq  0xfffffffffffaccb0
> >   36:	84 c0                	test   %al,%al
> >   38:	75 04                	jne    0x3e
> >   3a:	31 c0                	xor    %eax,%eax
> >   3c:	5b                   	pop    %rbx
> >   3d:	c3                   	retq   
> >   3e:	48                   	rex.W
> >   3f:	89                   	.byte 0x89
> > 
> > Code starting with the faulting instruction
> > ===========================================
> >    0:	48 8b b8 e8 00 00 00 	mov    0xe8(%rax),%rdi
> >    7:	e8 7a cc fa ff       	callq  0xfffffffffffacc86
> >    c:	84 c0                	test   %al,%al
> >    e:	75 04                	jne    0x14
> >   10:	31 c0                	xor    %eax,%eax
> >   12:	5b                   	pop    %rbx
> >   13:	c3                   	retq   
> >   14:	48                   	rex.W
> >   15:	89                   	.byte 0x89
> > RSP: 0018:ffffb79744f17d28 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8948c17aff00 RCX: 0000000000000000
> > RDX: 0000000000000004 RSI: ffffffffab1165ba RDI: ffff8948c17aff00
> > RBP: ffff8948c17aff00 R08: 0000000000000007 R09: ffff894927e547b2
> > R10: 0000000000000000 R11: ffff894927e549da R12: ffffb79744f17d38
> > R13: ffff8948c17aff00 R14: ffff89489bef9400 R15: ffff89488b775a80
> > FS:  00007fa54ad43700(0000) GS:ffff8949363c0000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > BUG: unable to handle kernel NULL pointer dereference at 00000000000000e8
> > #PF error: [normal kernel read fault]
> > PGD 0 P4D 0
> > Oops: 0000 [#1] PREEMPT SMP PTI
> > CPU: 7 PID: 2687 Comm: StreamTrans #56 Tainted: G     U            4.20.0-rc7-next-20181221-beppy+ #15
> > Hardware name: Dell Inc. XPS 13 9360/0TPN17, BIOS 2.10.0 09/27/2018
> > RIP: 0010:transparent_hugepage_enabled+0x1a/0xa0
> > Code: 17 fd 00 e9 20 ff ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 89 fb 48 83 bf 90 00 00 00 00 74 27 48 8b 87 a0 00 00 00 <48> 8b b8 e8 00 00 00 e8 7a cc fa ff 84 c0 75 04 31 c0 5b c3 48 89
> > RSP: 0018:ffffb79744f17d28 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8948c17aff00 RCX: 0000000000000000
> > RDX: 0000000000000004 RSI: ffffffffab1165ba RDI: ffff8948c17aff00
> > RBP: ffff8948c17aff00 R08: 0000000000000007 R09: ffff894927e547b2
> > R10: 0000000000000000 R11: ffff894927e549da R12: ffffb79744f17d38
> > R13: ffff8948c17aff00 R14: ffff89489bef9400 R15: ffff89488b775a80
> > FS:  00007fa54ad43700(0000) GS:ffff8949363c0000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000000e8 CR3: 000000025c0ee003 CR4: 00000000003606e0
> > Call Trace:
> >  show_smap+0xd7/0x200
> >  seq_read+0x2e8/0x410
> >  __vfs_read+0x36/0x1a0
> >  vfs_read+0x8a/0x140
> >  ksys_read+0x52/0xc0
> >  do_syscall_64+0x48/0xf0
> >  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > RIP: 0033:0x7fa585fb3184
> > Code: c3 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 5b fc ff ff 4c 89 e2 48 89 ee 89 df 41 89 c0 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 38 44 89 c7 48 89 44 24 08 e8 97 fc ff ff 48
> > RSP: 002b:00007fa54ad42060 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
> > RAX: ffffffffffffffda RBX: 000000000000002c RCX: 00007fa585fb3184
> > RDX: 0000000000001fff RSI: 00007fa54ffb2000 RDI: 000000000000002c
> > RBP: 00007fa54ffb2000 R08: 0000000000000000 R09: 000000000000001e
> > R10: 00007fa585c0dae0 R11: 0000000000000246 R12: 0000000000001fff
> > R13: 00007fa54ad42510 R14: 00007fa54ffb2fc5 R15: 00007fa54ad42498
> > Modules linked in: thunderbolt sch_cake rfcomm fuse arc4 iwlmvm mac80211 btusb btrtl btbcm btintel bnep bluetooth iwlwifi snd_hda_codec_hdmi ecdh_generic snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel cfg80211 snd_hda_codec nf_log_ipv6 ip6t_REJECT nf_reject_ipv6 snd_hwdep xt_hl snd_hda_core ip6t_rt nf_log_ipv4 nf_log_common joydev snd_pcm mousedev ipt_REJECT nf_reject_ipv4 hid_multitouch intel_rapl xt_LOG xt_comment nls_iso8859_1 intel_pmc_core nls_cp437 intel_powerclamp xt_limit kvm_intel xt_addrtype xt_tcpudp dell_laptop snd_timer xt_conntrack ledtrig_audio snd dell_wmi nf_conntrack efi_pstore dell_smbios mei_me dcdbas input_leds idma64 mei wmi_bmof intel_wmi_thunderbolt dell_wmi_descriptor efivars rfkill intel_pch_thermal intel_lpss_pci processor_thermal_device i2c_i801 soundcore intel_lpss intel_soc_dts_iosf i2c_hid evdev int3403_thermal int3400_thermal intel_vbtn rtc_cmos int340x_thermal_zone acpi_thermal_rel intel_hid mac_hid nf_defrag_ipv6 nf_defrag_ipv4
> >  ip6table_filter ip6_tables iptable_filter bpfilter coretemp msr dell_smm_hwmon crypto_user ip_tables x_tables algif_skcipher af_alg rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul xhci_pci ghash_clmulni_intel serio_raw rtsx_pci xhci_hcd i915 kvmgt vfio_mdev mdev vfio_iommu_type1 vfio kvm irqbypass intel_gtt
> > CR2: 00000000000000e8
> > ---[ end trace 77d24d35c4e5213f ]---
> > RIP: 0010:transparent_hugepage_enabled+0x1a/0xa0
> > Code: 17 fd 00 e9 20 ff ff ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53 48 89 fb 48 83 bf 90 00 00 00 00 74 27 48 8b 87 a0 00 00 00 <48> 8b b8 e8 00 00 00 e8 7a cc fa ff 84 c0 75 04 31 c0 5b c3 48 89
> > RSP: 0018:ffffb79744f17d28 EFLAGS: 00010282
> > RAX: 0000000000000000 RBX: ffff8948c17aff00 RCX: 0000000000000000
> > RDX: 0000000000000004 RSI: ffffffffab1165ba RDI: ffff8948c17aff00
> > RBP: ffff8948c17aff00 R08: 0000000000000007 R09: ffff894927e547b2
> > R10: 0000000000000000 R11: ffff894927e549da R12: ffffb79744f17d38
> > R13: ffff8948c17aff00 R14: ffff89489bef9400 R15: ffff89488b775a80
> > FS:  00007fa54ad43700(0000) GS:ffff8949363c0000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00000000000000e8 CR3: 000000025c0ee003 CR4: 00000000003606e0
> 
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

-- 
Sincerely yours,
Mike.

