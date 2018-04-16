Return-Path: <shuahkh@osg.samsung.com>
X-Google-Smtp-Source: AIpwx4+uy07glUsIhE7XyiHilUfkSGU7WfPjw5bDKofPwS9C3juSlTCTUJLndRMtt4o68igI5yzT
ARC-Seal: i=1; a=rsa-sha256; t=1523898091; cv=none;
        d=google.com; s=arc-20160816;
        b=DxyayiqyPD8w7oGX+g1bB3Ny+GWwAIF3BJsVzvanYmSeKTzuZnG9XiBmCJYR/9OOaM
         kf+UUvDFJkU9sWmOA8R+YekFuO1DSohyu5zUMfSf5yDzeBGyhkdS1sKA2fxeNXqtDx0r
         0vVXE2YePvkAKDX3Dd7JrnHdbBn9MurBukxOfP96V3MW4CoXD325Mkp4uh4CJ8W3wboj
         OrU6Aoa+MDQiXe5FnHl3lxkyqVisjIKHlKXLTCZH0mS1HIBFkK6vT3wTvYAPtPZXzro3
         xs2fv7cf4MkC8c8ESehK/CIKe+ToMeh9qXbnVJdUekn2EJbM5r/CopHy2/ds94bpar3R
         7OTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:mime-version:user-agent
         :date:message-id:autocrypt:openpgp:subject:from:cc:to
         :arc-authentication-results;
        bh=xkC06fECQla3Wi1k8lWZvWl18mcJnJBjd29bG7lSnCM=;
        b=TaEKMlL5SVrbXB6+IdvbZWDmDowizXKqaIC7J2onV5D//wv11pjmXJOaVEsO6pSInC
         0U4Vzls1IrtXY5VaZSsZbLmjHtPXZsiUyeCx0lEv9MZEAcq03The0++bVyxIfxgowsd5
         UoJBHxXcOqSzOIViqv3zdF68We2dshdTVzkslSEPIFjpI23XVG+nM/Xm+020M8Grr2bV
         dez8qAWaCuKQ7/FttfkHal2QdBvK3ppI5I3AEyhDuxXlhQWQyzYfNuXQo50iW9zpmuO9
         j9hEmzlJpqTZbuMwfU5Qw/QCtBX/+sHyMDPGN29B9gMUWMqyzbv4i36uw2StO/nhwOJy
         cCQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of shuahkh@osg.samsung.com designates 64.30.133.232 as permitted sender) smtp.mailfrom=shuahkh@osg.samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
To: Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 x86@kernel.org, stable@kernel.org
From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: Linux 4.17-rc1 - kernel paging errors running x86 selftests
Openpgp: preference=signencrypt
Autocrypt: addr=shuahkh@osg.samsung.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <1dcd116c-9384-6885-2d9e-f620c14bd955@osg.samsung.com>
Date: Mon, 16 Apr 2018 11:01:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597922964171604923?=
X-GMAIL-MSGID: =?utf-8?q?1597922964171604923?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andy/Ingo,

While running test_vsyscall_64 and fsgsbase_64 tests, I am seeing
the following errors in dmesg.

Also these tests either take forever to run or hang. I killed it after
waiting for an hour or so.  Unfortunately it makes the kselftest suite
pain to run. Could you please take a look and see if we need to disable
the tests for the time being or any way to make them not painful.

These tests went into stable as well? These commits went through x86 tree
and I didn't get a chance to run the. Did you see these problems when you
ran them on your test systems. I do have KASAN enabled on mine.

[  884.496588] BUG: unable to handle kernel paging request at fffffe8000010030
[  884.496601] PGD 372870067 P4D 372870067 PUD 346e84067 PMD 34005f067 PTE ffffffffffffffff
[  884.496614] Oops: 0009 [#1] SMP KASAN PTI
[  884.496619] Modules linked in: iptable_mangle xt_tcpudp bridge stp llc iptable_filter binfmt_misc gpio_ich x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd cryptd glue_helper snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic wmi_bmof snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm lpc_ich snd_timer mac_hid parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs xor zstd_decompress zstd_compress xxhash raid6_pq libcrc32c dm_mirror dm_region_hash dm_log hid_generic usbhid hid i915 iosf_mbi i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm r8169 mii wmi video
[  884.496730] CPU: 1 PID: 8200 Comm: sigreturn_64 Not tainted 4.17.0-rc1 #1
[  884.496735] Hardware name: System76, Inc. Wild Dog Performance/H87-PLUS, BIOS 0705 12/05/2013
[  884.496741] RIP: 0033:0x4031c2
[  884.496745] RSP: 002b:00007ffd805b56d8 EFLAGS: 00010246
[  884.496751] RAX: 0000000000000000 RBX: 0000000000000010 RCX: 0000000000000000
[  884.496756] RDX: 0000000000400000 RSI: 0000000000000000 RDI: 0000000000000037
[  884.496760] RBP: 0000000000000000 R08: 0000000000000037 R09: 0000000000000033
[  884.496765] R10: 0000000000000010 R11: 0000000000000000 R12: 00000000ffffffff
[  884.496769] R13: 0000000000402000 R14: 0000000000000000 R15: 0000000000000000
[  884.496774] FS:  00007f9445162740(0000) GS:ffff8803cfc40000(0000) knlGS:0000000000000000
[  884.496779] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  884.496783] CR2: fffffe8000010030 CR3: 000000036c5c2002 CR4: 00000000001606e0
[  884.496788] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  884.496792] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  884.496798] RIP: 0x4031c2 RSP: 00007ffd805b56d8
[  884.496802] CR2: fffffe8000010030
[  884.496807] ---[ end trace 286073d5ab6d2df6 ]---
[  884.650095] BUG: unable to handle kernel paging request at fffffe8000000000
[  884.650103] PGD 363699067 P4D 363699067 PUD 3371c6067 PMD 37cfbc067 PTE ffffffffffffffff
[  884.650112] Oops: 0009 [#2] SMP KASAN PTI
[  884.650115] Modules linked in: iptable_mangle xt_tcpudp bridge stp llc iptable_filter binfmt_misc gpio_ich x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass ghash_clmulni_intel pcbc aesni_intel aes_x86_64 crypto_simd cryptd glue_helper snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic wmi_bmof snd_hda_intel snd_hda_codec snd_hda_core snd_hwdep snd_pcm lpc_ich snd_timer mac_hid parport_pc ppdev lp parport ip_tables x_tables autofs4 btrfs xor zstd_decompress zstd_compress xxhash raid6_pq libcrc32c dm_mirror dm_region_hash dm_log hid_generic usbhid hid i915 iosf_mbi i2c_algo_bit drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops drm r8169 mii wmi video
[  884.650192] CPU: 0 PID: 8251 Comm: fsgsbase_64 Tainted: G      D           4.17.0-rc1 #1
[  884.650195] Hardware name: System76, Inc. Wild Dog Performance/H87-PLUS, BIOS 0705 12/05/2013
[  884.650200] RIP: 0033:0x401471
[  884.650203] RSP: 002b:00007fc8e6775eb0 EFLAGS: 00010206
[  884.650206] RAX: 0000000000000007 RBX: 00000000006030a8 RCX: 0000000000000b40
[  884.650210] RDX: 00007fc8e6b53880 RSI: 0000000000401918 RDI: 00007fc8e6b52720
[  884.650213] RBP: a1fa5f343cb85fa4 R08: 00007fc8e6776700 R09: baadf00d00000000
[  884.650215] R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000401727
[  884.650218] R13: 0000000000401726 R14: 0000000200000000 R15: 00007fc8e67769c0
[  884.650222] FS:  00007fc8e6776700(0000) GS:ffff8803cfc00000(0000) knlGS:0000000000000000
[  884.650225] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  884.650228] CR2: fffffe8000000000 CR3: 0000000371d32001 CR4: 00000000001606f0
[  884.650231] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  884.650233] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  884.650237] RIP: 0x401471 RSP: 00007fc8e6775eb0
[  884.650240] CR2: fffffe8000000000
[  884.650244] ---[ end trace 286073d5ab6d2df7 ]---


thanks,
-- Shuah
