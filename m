Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 451C1C07E85
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDB6A2081F
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 10:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="khbw9s5m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDB6A2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbeLIKh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 05:37:57 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:33526 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbeLIKh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 05:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=V28/jOgEw0hSqFM6gCHI4O7G2a25ciSSb3eLB7lLxH0=; b=khbw9s5mqaGpgqu5dCT0qs5Tt
        Cr6A5Zovk6sCyycQ1MT/KMIVtVmEuNPP9UmLBZ03KjFxnW7FK4uQU8Q4qsHj4ius+D3vZ69ikt08x
        ksav6ojQlSdHZloeLY4hlNYqV0mBcn4h5leXKu5XpjFWDnmv7Z1Nmo7Gx4+wszJoJBMpU=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:48890)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gVwT5-0002Pc-Hd; Sun, 09 Dec 2018 10:37:47 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gVwT0-0001yd-Q6; Sun, 09 Dec 2018 10:37:42 +0000
Date:   Sun, 9 Dec 2018 10:37:40 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     kbuild test robot <lkp@intel.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, kbuild-all@01.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
Message-ID: <20181209103740.GB30658@n2100.armlinux.org.uk>
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <201812091807.4emRkZ7L%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201812091807.4emRkZ7L%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 09, 2018 at 06:28:11PM +0800, kbuild test robot wrote:
> Hi Ard,
> 
> I love your patch! Perhaps something to improve:

Hi,

This looks to me like a false warning - how can a patch touching arch
code affect the result of lib/test_ubsan.c?  Please can you double-
check this result?

Thanks.

> 
> [auto build test WARNING on arm/for-next]
> [also build test WARNING on v4.20-rc5]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Ard-Biesheuvel/ARM-smp-add-support-for-per-task-stack-canaries/20181209-033321
> base:   git://git.armlinux.org.uk/~rmk/linux-arm.git for-next
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.2.0 make.cross ARCH=arm 
> 
> All warnings (new ones prefixed by >>):
> 
>    lib/test_ubsan.c: In function 'test_ubsan_vla_bound_not_positive':
> >> lib/test_ubsan.c:48:2: warning: ISO C90 forbids variable length array 'buf' [-Wvla]
>      char buf[size];
>      ^~~~
>    lib/test_ubsan.c: In function 'test_ubsan_out_of_bounds':
> >> lib/test_ubsan.c:64:2: warning: ISO C90 forbids variable length array 'arr' [-Wvla]
>      volatile int arr[i];
>      ^~~~~~~~
> 
> vim +/buf +48 lib/test_ubsan.c
> 
> 854686f4 Jinbum Park 2018-04-10  44  
> 854686f4 Jinbum Park 2018-04-10  45  static void test_ubsan_vla_bound_not_positive(void)
> 854686f4 Jinbum Park 2018-04-10  46  {
> 854686f4 Jinbum Park 2018-04-10  47  	volatile int size = -1;
> 854686f4 Jinbum Park 2018-04-10 @48  	char buf[size];
> 854686f4 Jinbum Park 2018-04-10  49  
> 854686f4 Jinbum Park 2018-04-10  50  	(void)buf;
> 854686f4 Jinbum Park 2018-04-10  51  }
> 854686f4 Jinbum Park 2018-04-10  52  
> 854686f4 Jinbum Park 2018-04-10  53  static void test_ubsan_shift_out_of_bounds(void)
> 854686f4 Jinbum Park 2018-04-10  54  {
> 854686f4 Jinbum Park 2018-04-10  55  	volatile int val = -1;
> 854686f4 Jinbum Park 2018-04-10  56  	int val2 = 10;
> 854686f4 Jinbum Park 2018-04-10  57  
> 854686f4 Jinbum Park 2018-04-10  58  	val2 <<= val;
> 854686f4 Jinbum Park 2018-04-10  59  }
> 854686f4 Jinbum Park 2018-04-10  60  
> 854686f4 Jinbum Park 2018-04-10  61  static void test_ubsan_out_of_bounds(void)
> 854686f4 Jinbum Park 2018-04-10  62  {
> 854686f4 Jinbum Park 2018-04-10  63  	volatile int i = 4, j = 5;
> 854686f4 Jinbum Park 2018-04-10 @64  	volatile int arr[i];
> 854686f4 Jinbum Park 2018-04-10  65  
> 854686f4 Jinbum Park 2018-04-10  66  	arr[j] = i;
> 854686f4 Jinbum Park 2018-04-10  67  }
> 854686f4 Jinbum Park 2018-04-10  68  
> 
> :::::: The code at line 48 was first introduced by commit
> :::::: 854686f4edf483db1e0d26d972bdb8fb65c8bfaa lib: add testing module for UBSAN
> 
> :::::: TO: Jinbum Park <jinb.park7@gmail.com>
> :::::: CC: Linus Torvalds <torvalds@linux-foundation.org>
> 
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation



-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
