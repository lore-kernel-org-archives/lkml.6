Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbeC2QQa convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:16:30 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15930 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751968AbeC2QQ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:16:28 -0400
Date: Thu, 29 Mar 2018 18:16:09 +0200
Message-ID: <20180329181609.Horde.TWj0eWAkAjHcBe3PlwHHEQ6@messagerie.si.c-s.fr>
From: LEROY Christophe <christophe.leroy@c-s.fr>
To: Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 05/19] powerpc/chrp/setup: Add attribute unused and
 make some functions static
References: <20180322202007.23088-6-malat@debian.org>
 <20180328193553.1122-1-malat@debian.org>
In-Reply-To: <20180328193553.1122-1-malat@debian.org>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject of the patch should be updated as well

Christophe


Mathieu Malaterre <malat@debian.org> a écrit :

> Remove variable declaration idu_size and associated code since not used.
>
> These functions can all be static, make it so. Fix warnings treated as
> errors with W=1:
>
>   arch/powerpc/platforms/chrp/setup.c:97:6: error: no previous  
> prototype for ‘chrp_show_cpuinfo’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:302:13: error: no previous  
> prototype for ‘chrp_setup_arch’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:385:16: error: variable  
> ‘idu_size’ set but not used [-Werror=unused-but-set-variable]
>   arch/powerpc/platforms/chrp/setup.c:526:13: error: no previous  
> prototype for ‘chrp_init_IRQ’ [-Werror=missing-prototypes]
>   arch/powerpc/platforms/chrp/setup.c:559:1: error: no previous  
> prototype for ‘chrp_init2’ [-Werror=missing-prototypes]
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> ---
> v2: Remove totally variable idu_size
>  arch/powerpc/platforms/chrp/setup.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/arch/powerpc/platforms/chrp/setup.c  
> b/arch/powerpc/platforms/chrp/setup.c
> index 481ed133e04b..d6d8ffc0271e 100644
> --- a/arch/powerpc/platforms/chrp/setup.c
> +++ b/arch/powerpc/platforms/chrp/setup.c
> @@ -94,7 +94,7 @@ static const char *chrp_names[] = {
>  	"Total Impact Briq"
>  };
>
> -void chrp_show_cpuinfo(struct seq_file *m)
> +static void chrp_show_cpuinfo(struct seq_file *m)
>  {
>  	int i, sdramen;
>  	unsigned int t;
> @@ -299,7 +299,7 @@ static __init void chrp_init(void)
>  	of_node_put(node);
>  }
>
> -void __init chrp_setup_arch(void)
> +static void __init chrp_setup_arch(void)
>  {
>  	struct device_node *root = of_find_node_by_path("/");
>  	const char *machine = NULL;
> @@ -382,7 +382,7 @@ static void __init chrp_find_openpic(void)
>  {
>  	struct device_node *np, *root;
>  	int len, i, j;
> -	int isu_size, idu_size;
> +	int isu_size;
>  	const unsigned int *iranges, *opprop = NULL;
>  	int oplen = 0;
>  	unsigned long opaddr;
> @@ -427,11 +427,9 @@ static void __init chrp_find_openpic(void)
>  	}
>
>  	isu_size = 0;
> -	idu_size = 0;
>  	if (len > 0 && iranges[1] != 0) {
>  		printk(KERN_INFO "OpenPIC irqs %d..%d in IDU\n",
>  		       iranges[0], iranges[0] + iranges[1] - 1);
> -		idu_size = iranges[1];
>  	}
>  	if (len > 1)
>  		isu_size = iranges[3];
> @@ -523,7 +521,7 @@ static void __init chrp_find_8259(void)
>  	}
>  }
>
> -void __init chrp_init_IRQ(void)
> +static void __init chrp_init_IRQ(void)
>  {
>  #if defined(CONFIG_VT) && defined(CONFIG_INPUT_ADBHID) &&  
> defined(CONFIG_XMON)
>  	struct device_node *kbd;
> @@ -555,7 +553,7 @@ void __init chrp_init_IRQ(void)
>  #endif
>  }
>
> -void __init
> +static void __init
>  chrp_init2(void)
>  {
>  #ifdef CONFIG_NVRAM
> --
> 2.11.0
