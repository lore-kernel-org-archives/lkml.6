Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DBDBC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABAB020869
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAB020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=de.ibm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbeJ0Qxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 12:53:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33954 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728020AbeJ0Qxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 12:53:51 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w9R8DfF6017609
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 04:13:41 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ncjbnu6sk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 04:13:41 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Sat, 27 Oct 2018 09:13:39 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sat, 27 Oct 2018 09:13:36 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id w9R8DZFr7864824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 27 Oct 2018 08:13:35 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D1788A4053;
        Sat, 27 Oct 2018 08:13:35 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B260DA404D;
        Sat, 27 Oct 2018 08:13:35 +0000 (GMT)
Received: from oc7455500831.ibm.com (unknown [9.145.50.251])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sat, 27 Oct 2018 08:13:35 +0000 (GMT)
Subject: Re: Linux kernel crash
To:     Stephen Smith <ischis2@cox.net>, linux-kernel@vger.kernel.org
References: <1654617.UvxYW9xS0L@thunderbird> <8609715.XleivgsqJ9@thunderbird>
From:   Christian Borntraeger <borntraeger@de.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=borntraeger@de.ibm.com; prefer-encrypt=mutual; keydata=
 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
 syiRa+UVlsKmx1hsEg==
Date:   Sat, 27 Oct 2018 10:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <8609715.XleivgsqJ9@thunderbird>
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18102708-0028-0000-0000-0000030E3123
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18102708-0029-0000-0000-000023CA5044
Message-Id: <e684dd79-7bf9-1685-a06a-438eb8385b28@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810270077
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/27/2018 06:07 AM, Stephen Smith wrote:
> On Wednesday, October 24, 2018 10:20:05 PM MST Stephen Smith wrote:
>>
>> Whenever I run "shutdown -h now" or "reboot" I receive an immediate kernel
>> crash with a dump that has:
>>
>> "Code: Bad RIP value"
> 
> I Canonical response noted  the following from the dump:
> 
> [ 42.640541] resource sanity check: requesting [mem 0x000c0000-0x000fffff], 
> which spans more than PCI Bus 0000:00 [mem 0x000c0000-0x000dffff window]
> 
> I've since updated to the latest BIOS at there suggestion.   
> 
> I see the following on the screen when the kernel crashes:
> [   43.115817] WARNING: CPU: 2 PID: 1847 at mm/usercopy.c:81 
> usercopy_warn+0x81/0xa0
> [   43.115818] Modules linked in: binfmt_misc snd_hda_codec_hdmi 
> snd_hda_codec_realtek snd_hda_codec_generic edac_mce_amd snd_hda_intel kvm_amd 
> kvm snd_hda_codec snd_hda_core irqbypass crct10dif_pclmul crc32_pclmul 
> snd_hwdep snd_pcm snd_seq_midi snd_seq_midi_event ghash_clmulni_intel 
> snd_rawmidi snd_seq pcbc aesni_intel snd_seq_device snd_timer eeepc_wmi 
> asus_wmi sparse_keymap aes_x86_64 joydev snd video crypto_simd cryptd 
> soundcore wmi_bmof glue_helper input_leds wmi k10temp ccp serio_raw 
> nvidia_uvm(POE) mac_hid sch_fq_codel parport_pc ppdev lp parport ip_tables 
> x_tables autofs4 raid10 raid456 async_raid6_recov async_memcpy async_pq 
> async_xor async_tx xor raid6_pq libcrc32c raid0 multipath linear raid1 
> hid_generic usbhid hid nvidia_drm(POE) nvidia_modeset(POE) nvidia(POE) 
> drm_kms_helper syscopyarea
> [   43.115849]  sysfillrect sysimgblt fb_sys_fops drm r8169 ipmi_devintf 
> i2c_piix4 ipmi_msghandler mii ahci libahci gpio_amdpt gpio_generic
> [   43.115856] CPU: 2 PID: 1847 Comm: Xorg Tainted: P           OE     
> 4.18.0-10-generic #11-Ubuntu
> [   43.115857] Hardware name: System manufacturer System Product Name/PRIME 
> B350-PLUS, BIOS 0406 02/07/2017
> [   43.115859] RIP: 0010:usercopy_warn+0x81/0xa0
> [   43.115859] Code: 10 99 41 51 4d 89 d8 48 c7 c0 89 8d 0f 99 49 89 f1 48 89 
> f9 48 0f 45 c2 48 c7 c7 f0 a1 10 99 4c 89 d2 48 89 c6 e8 f1 cf df ff <0f> 0b 
> 48 83 c4 18 c9 c3 48 c7 c6 b2 8a 12 99 49 89 f1 49 89 f3 eb 
> [   43.115875] RSP: 0018:ffffb0c741f07b08 EFLAGS: 00010286
> [   43.115876] RAX: 0000000000000000 RBX: ffff9beec5c42cb0 RCX: 
> 0000000000000006
> [   43.115876] RDX: 0000000000000007 RSI: 0000000000000096 RDI: 
> ffff9beece6964b0
> [   43.115877] RBP: ffffb0c741f07b20 R08: 0000000000000001 R09: 
> 0000000000000392
> [   43.115878] R10: 0000000000000004 R11: 0000000000000000 R12: 
> 0000000000000003
> [   43.115878] R13: 0000000000000001 R14: ffff9beec5c42cb3 R15: 
> ffff9beec5c42cf8
> [   43.115879] FS:  00007f6267654a80(0000) GS:ffff9beece680000(0000) knlGS:
> 0000000000000000
> [   43.115880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   43.115881] CR2: 00007f6263cc5d20 CR3: 0000000402fb0000 CR4: 
> 00000000003406e0
> [   43.115881] Call Trace:
> [   43.115886]  __check_heap_object+0xc2/0x110
> [   43.115887]  __check_object_size+0x14c/0x178
> [   43.116024]  os_memcpy_to_user+0x26/0x50 [nvidia]
> [   43.116158]  _nv009384rm+0xbf/0xe0 [nvidia]
> [   43.116159] WARNING: kernel stack frame pointer at 00000000e73eb0f3 in 

The newer kernels (like 4.18) have checks regarding copies to userspace for
unwanted kernel memory exposure.
The check fails here. This particular copy was initiated by the binary nvidia 
driver, so unfortunately we cannot help here. So either ask Nvidia for a fix 
or (if that driver was installed with the Ubuntu software updater)  Canonical.

