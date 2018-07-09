Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749EEC6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C4C020875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 14:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C4C020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933136AbeGIOy7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 10:54:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:21104 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932798AbeGIOy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 10:54:56 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2018 07:54:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,330,1526367600"; 
   d="scan'208";a="69825701"
Received: from precciox-mobl.amr.corp.intel.com (HELO [10.254.107.89]) ([10.254.107.89])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jul 2018 07:54:55 -0700
Subject: Re: Kernel 4.17.4 lockup
To:     "H.J. Lu" <hjl.tools@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.hansen@intel.com; keydata=
 xsFNBE6HMP0BEADIMA3XYkQfF3dwHlj58Yjsc4E5y5G67cfbt8dvaUq2fx1lR0K9h1bOI6fC
 oAiUXvGAOxPDsB/P6UEOISPpLl5IuYsSwAeZGkdQ5g6m1xq7AlDJQZddhr/1DC/nMVa/2BoY
 2UnKuZuSBu7lgOE193+7Uks3416N2hTkyKUSNkduyoZ9F5twiBhxPJwPtn/wnch6n5RsoXsb
 ygOEDxLEsSk/7eyFycjE+btUtAWZtx+HseyaGfqkZK0Z9bT1lsaHecmB203xShwCPT49Blxz
 VOab8668QpaEOdLGhtvrVYVK7x4skyT3nGWcgDCl5/Vp3TWA4K+IofwvXzX2ON/Mj7aQwf5W
 iC+3nWC7q0uxKwwsddJ0Nu+dpA/UORQWa1NiAftEoSpk5+nUUi0WE+5DRm0H+TXKBWMGNCFn
 c6+EKg5zQaa8KqymHcOrSXNPmzJuXvDQ8uj2J8XuzCZfK4uy1+YdIr0yyEMI7mdh4KX50LO1
 pmowEqDh7dLShTOif/7UtQYrzYq9cPnjU2ZW4qd5Qz2joSGTG9eCXLz5PRe5SqHxv6ljk8mb
 ApNuY7bOXO/A7T2j5RwXIlcmssqIjBcxsRRoIbpCwWWGjkYjzYCjgsNFL6rt4OL11OUF37wL
 QcTl7fbCGv53KfKPdYD5hcbguLKi/aCccJK18ZwNjFhqr4MliQARAQABzShEYXZpZCBDaHJp
 c3RvcGhlciBIYW5zZW4gPGRhdmVAc3I3MS5uZXQ+wsF7BBMBAgAlAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAUCTo3k0QIZAQAKCRBoNZUwcMmSsMO2D/421Xg8pimb9mPzM5N7khT0
 2MCnaGssU1T59YPE25kYdx2HntwdO0JA27Wn9xx5zYijOe6B21ufrvsyv42auCO85+oFJWfE
 K2R/IpLle09GDx5tcEmMAHX6KSxpHmGuJmUPibHVbfep2aCh9lKaDqQR07gXXWK5/yU1Dx0r
 VVFRaHTasp9fZ9AmY4K9/BSA3VkQ8v3OrxNty3OdsrmTTzO91YszpdbjjEFZK53zXy6tUD2d
 e1i0kBBS6NLAAsqEtneplz88T/v7MpLmpY30N9gQU3QyRC50jJ7LU9RazMjUQY1WohVsR56d
 ORqFxS8ChhyJs7BI34vQusYHDTp6PnZHUppb9WIzjeWlC7Jc8lSBDlEWodmqQQgp5+6AfhTD
 kDv1a+W5+ncq+Uo63WHRiCPuyt4di4/0zo28RVcjtzlGBZtmz2EIC3vUfmoZbO/Gn6EKbYAn
 rzz3iU/JWV8DwQ+sZSGu0HmvYMt6t5SmqWQo/hyHtA7uF5Wxtu1lCgolSQw4t49ZuOyOnQi5
 f8R3nE7lpVCSF1TT+h8kMvFPv3VG7KunyjHr3sEptYxQs4VRxqeirSuyBv1TyxT+LdTm6j4a
 mulOWf+YtFRAgIYyyN5YOepDEBv4LUM8Tz98lZiNMlFyRMNrsLV6Pv6SxhrMxbT6TNVS5D+6
 UorTLotDZKp5+M7BTQRUY85qARAAsgMW71BIXRgxjYNCYQ3Xs8k3TfAvQRbHccky50h99TUY
 sqdULbsb3KhmY29raw1bgmyM0a4DGS1YKN7qazCDsdQlxIJp9t2YYdBKXVRzPCCsfWe1dK/q
 66UVhRPP8EGZ4CmFYuPTxqGY+dGRInxCeap/xzbKdvmPm01Iw3YFjAE4PQ4hTMr/H76KoDbD
 cq62U50oKC83ca/PRRh2QqEqACvIH4BR7jueAZSPEDnzwxvVgzyeuhwqHY05QRK/wsKuhq7s
 UuYtmN92Fasbxbw2tbVLZfoidklikvZAmotg0dwcFTjSRGEg0Gr3p/xBzJWNavFZZ95Rj7Et
 db0lCt0HDSY5q4GMR+SrFbH+jzUY/ZqfGdZCBqo0cdPPp58krVgtIGR+ja2Mkva6ah94/oQN
 lnCOw3udS+Eb/aRcM6detZr7XOngvxsWolBrhwTQFT9D2NH6ryAuvKd6yyAFt3/e7r+HHtkU
 kOy27D7IpjngqP+b4EumELI/NxPgIqT69PQmo9IZaI/oRaKorYnDaZrMXViqDrFdD37XELwQ
 gmLoSm2VfbOYY7fap/AhPOgOYOSqg3/Nxcapv71yoBzRRxOc4FxmZ65mn+q3rEM27yRztBW9
 AnCKIc66T2i92HqXCw6AgoBJRjBkI3QnEkPgohQkZdAb8o9WGVKpfmZKbYBo4pEAEQEAAcLB
 XwQYAQIACQUCVGPOagIbDAAKCRBoNZUwcMmSsJeCEACCh7P/aaOLKWQxcnw47p4phIVR6pVL
 e4IEdR7Jf7ZL00s3vKSNT+nRqdl1ugJx9Ymsp8kXKMk9GSfmZpuMQB9c6io1qZc6nW/3TtvK
 pNGz7KPPtaDzvKA4S5tfrWPnDr7n15AU5vsIZvgMjU42gkbemkjJwP0B1RkifIK60yQqAAlT
 YZ14P0dIPdIPIlfEPiAWcg5BtLQU4Wg3cNQdpWrCJ1E3m/RIlXy/2Y3YOVVohfSy+4kvvYU3
 lXUdPb04UPw4VWwjcVZPg7cgR7Izion61bGHqVqURgSALt2yvHl7cr68NYoFkzbNsGsye9ft
 M9ozM23JSgMkRylPSXTeh5JIK9pz2+etco3AfLCKtaRVysjvpysukmWMTrx8QnI5Nn5MOlJj
 1Ov4/50JY9pXzgIDVSrgy6LYSMc4vKZ3QfCY7ipLRORyalFDF3j5AGCMRENJjHPD6O7bl3Xo
 4DzMID+8eucbXxKiNEbs21IqBZbbKdY1GkcEGTE7AnkA3Y6YB7I/j9mQ3hCgm5muJuhM/2Fr
 OPsw5tV/LmQ5GXH0JQ/TZXWygyRFyyI2FqNTx4WHqUn3yFj8rwTAU1tluRUYyeLy0ayUlKBH
 ybj0N71vWO936MqP6haFERzuPAIpxj2ezwu0xb1GjTk4ynna6h5GjnKgdfOWoRtoWndMZxbA
 z5cecg==
Message-ID: <50d6bb50-5fa4-33d1-1f88-3844d0237f16@intel.com>
Date:   Mon, 9 Jul 2018 07:54:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMe9rOqXsQ4Onv8_-kYE_yVYVfN0Hsg81XM0sq9k2cVYE_LvaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 06:19 AM, Lu, Hongjiu wrote:
> On 3 x86-64 machines, kernel 4.17.4 locked up under heavy load. 2 of
them don't  have any kernel messages.  One has

Hi H.J.,

It'd be really handy if you could pastebin things like this, or attach a
text file with the oops. Your email wrapped the heck out of the oops and
I had to go and unwrap it to read it.

A full disassembly of free_pages_and_swap_cache() from the actual
vmlinux to account for differences between toolchains would be helpful.
It'll probably help me figure out what the loop counter was for
instance.  It makes it a bit easier to read random oopses if you boot
with 'nokaslr' because the pointer types (kernel text, linear map,
vmemmap, etc...) stick out much more easily. Would you be able to boot
with it in the future?

We've had a bit of churn in that code, but nothing between 4.16 and 4.17
that really sticks out to me in the x86 code.

The general protection fault is a bit of an oddball. If I disassembled
right, it's trying to dereference %R13+20. That doesn't even cross a
page boundary, so it's a bit hard to fathom where the #GP would come from.

(mostly) unwrapped oops below.

>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: general protection
>> fault: 0000 [#1] SMP PTI
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Modules linked in:
>> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache devlink ebtable_filter
>> ebtables ip6table_filter ip6_tables intel_rapl x86_pkg_temp_thermal
>> intel_powerclamp coretemp snd_hda_codec_hdmi snd_hda_codec_realtek
>> kvm_intel snd_hda_codec_generic snd_hda_intel kvm snd_hda_codec
>> snd_hda_core snd_hwdep irqbypass crct10dif_pclmul crc32_pclmul snd_seq
>> mei_wdt ghash_clmulni_intel snd_seq_device intel_cstate ppdev
>> intel_uncore iTCO_wdt gpio_ich iTCO_vendor_support snd_pcm
>> intel_rapl_perf snd_timer snd mei_me parport_pc joydev i2c_i801 mei
>> soundcore shpchp lpc_ich parport nfsd auth_rpcgss nfs_acl lockd grace
>> sunrpc i915 i2c_algo_bit drm_kms_helper r8169 drm crc32c_intel mii
>> video
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CPU: 7 PID: 7093 Comm:
>> cc1 Not tainted 4.17.4-200.0.fc28.x86_64 #1
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Hardware name: Gigabyte
>> Technology Co., Ltd. H87M-D3H/H87M-D3H, BIOS F11 08/18/2015
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: 0010:free_pages_and_swap_cache+0x29/0xb0
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP: 0018:ffffb2cd83ffbd58 EFLAGS: 00010202
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: 0017fffe00040068 RBX: ffff93d4abb5ec80 RCX: 0000000000000000
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0017fffe00040068 RSI: 00000000000001fe RDI: ffff93d51e3dd2a0
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 00000000000001fe R08: fffff0809df82d20 R09: ffff93d51e5d5000
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: ffff93d51e5d5e20 R11: ffff93d51e5d5d00 R12: ffff93d4abb5e010
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: fffbf0809e304bc0 R14: ffff93d4abb5f000 R15: ffff93d4cbcee8f0
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: FS: 0000000000000000(0000) GS:ffff93d51e3c0000(0000) knlGS:0000000000000000
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: CR2: 00007ffb255e753c CR3: 00000005e820a002 CR4: 00000000001606e0
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Call Trace: 
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_flush_mmu_free+0x31/0x50
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  arch_tlb_finish_mmu+0x42/0x70
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  tlb_finish_mmu+0x1f/0x30
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  exit_mmap+0xca/0x190
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  mmput+0x5f/0x130
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_exit+0x280/0xae0
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  ? __do_page_fault+0x263/0x4e0
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_group_exit+0x3a/0xa0
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  __x64_sys_exit_group+0x14/0x20
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel:  do_syscall_64+0x65/0x160
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: 0033:0x7ffb2542b3c6
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RSP: 002b:00007ffd9e7e33b8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RAX: ffffffffffffffda RBX: 00007ffb2551c740 RCX: 00007ffb2542b3c6
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RDX: 0000000000000000 RSI: 000000000000003c RDI: 0000000000000000
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RBP: 0000000000000000 R08: 00000000000000e7 R09: fffffffffffffe70
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R10: 00007ffd9e7e3250 R11: 0000000000000246 R12: 00007ffb2551c740
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: R13: 0000000000000037 R14: 00007ffb25525708 R15: 0000000000000000
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: Code: 40 00 0f 1f 44 00 00 41 56 41 55 41 54 49 89 fc 55 89 f5 53 e8 29 99 fb ff 85 ed 7e 6b 8d 45 ff 4c 89 e3 4d 8d 74 c4 08 4c 8b 2b <49> 8b 55 20 48 8d 42 ff 83 e2 01 49 0f 44 c5 48 8b 48 20 48 8d
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: RIP: free_pages_and_swap_cache+0x29/0xb0 RSP: ffffb2cd83ffbd58
>> Jul 05 14:33:32 gnu-hsw-1.sc.intel.com kernel: ---[ end trace 5960277fd8a3c0b5 ]---
