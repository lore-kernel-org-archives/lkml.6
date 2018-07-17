Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 515A0ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:33:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1094420850
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 14:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1094420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731789AbeGQPG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 11:06:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:39681 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729673AbeGQPG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 11:06:28 -0400
Received: from [0.0.0.0] ([210.140.77.29]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MdKkd-1fO2e7105L-00IWLY; Tue, 17
 Jul 2018 16:33:17 +0200
Subject: Re: [PATCH] btrfs: fix size_t format string
To:     Arnd Bergmann <arnd@arndb.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <jbacik@fb.com>, David Sterba <dsterba@suse.com>
Cc:     Qu Wenruo <wqu@suse.com>, Nikolay Borisov <nborisov@suse.com>,
        Su Yue <suy.fnst@cn.fujitsu.com>, linux-btrfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180717135236.3673195-1-arnd@arndb.de>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <dbbb1882-65bf-dda9-eb26-a6217b240def@gmx.com>
Date:   Tue, 17 Jul 2018 22:33:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180717135236.3673195-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:F1xnq0o2aptKzFU+78mvZPnsdHUk71JnT0hczhGWCLkXDQ7QZ6B
 9xVytWy2KdVf1B18VJ7QGsMmm2VQjzyZry/e7GlV5Z+3xKvOhVFX3iZoczgUN9pTk0kWz2H
 fWJKkd8mxnWFmZ/ph7TcAWFR5XduOjxUzyo8pJDsKE27k47MXBJrggQUL2QYdRgtKP5Yf08
 zdBMJM1PU8Ul2pE82ltig==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PVdPamnmaeo=:KaEdfiveKTMG3TNSH0JDKa
 RTfqyt9XLph+V9ug6S0cizi8ihmHDhevqVUPOdJOXU5wfNieUkLDTNlIF18jvgTt41rF6T4Js
 5psYJLizF1Inn5WlM5A0Y4vJFKMMHbX9c9eqFpSikT2Ygt2N3TYIeV7+4wn76crzqXyPMEOif
 fpKicykdnE8y6QF1l5z5R3kCqCRBap/LwU949HPEnteEQifxsrBQ7y0q71ZomIOvZ44tz7+EL
 v0mZkzMVPacImA4OzgWHnuB817Ir6Qnmyke65Wn1Ssff8ys9klrADy4fH7wk2wJEiomkGvq8N
 2y+UMaNvO8KRx86/rRD2NzC7BT62uCvvgdcXNXdCS9P1ZY47BSi0uocXvtM4UhmGL4AImaXZK
 W03zmzxjjX91w6bdE2Du7oDAq43YGo1bwiMKqe+KjjyJRh4F4X8LuWM5iy/l2Npm2OOeuASM0
 kTAEENVxGjUcVUc7wHV4DXpPwHnYpLcd/wllJFtPKFRA/dJFI93n7lzXOIQ1RIYJqAyxIcb/+
 Af4taOuanRq4JwlJCm58pECrlZmmVsFS/I1XCpZb01tlpyuuW0GmqVH40gCZc8Uz4r8OUSjKL
 Sf3S/HCJIDtCkXQCJJ/yJrZau6MKNGxLBlRG7tqcH6v7DinAy78wp9AutNz0iIhi+mw0C+S0j
 Vcd1UltZSA3CU6eqwZ8g1Ljgg/WWkG6/WHryfJv7hRrXGDgoJRGGoYVWtwFodJc9P3nE3mtaA
 3NAr62kJHZHPG9GNNgIcTVrcqGasHEimIgbMLO4tNCoshqSIcQ7V6PtTDnVLWYO0K5bnTBcae
 5Jkv6Gz
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018年07月17日 21:52, Arnd Bergmann wrote:
> The newly added check_block_group_item() function causes a build warning
> on 32-bit architectures:
> 
> fs/btrfs/tree-checker.c: In function 'check_block_group_item':
> fs/btrfs/tree-checker.c:404:41: error: format '%lu' expects argument of type 'long unsigned int', but argument 6 has type 'unsigned int' [-Werror=format=]
> 
> The type of a sizeof() expression is size_t, which is correctly printed
> using the %zu format string.
> 
> Fixes: 9dc16aad5660 ("btrfs: tree-checker: Verify block_group_item")

My fault again. :(

Is there anyway to make gcc report such problem even under x86_64?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>  fs/btrfs/tree-checker.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/btrfs/tree-checker.c b/fs/btrfs/tree-checker.c
> index e9414c3f375e..4c82a628df85 100644
> --- a/fs/btrfs/tree-checker.c
> +++ b/fs/btrfs/tree-checker.c
> @@ -401,7 +401,7 @@ static int check_block_group_item(struct btrfs_fs_info *fs_info,
>  
>  	if (item_size != sizeof(bgi)) {
>  		block_group_err(fs_info, leaf, slot,
> -			"invalid item size, have %u expect %lu",
> +			"invalid item size, have %u expect %zu",
>  				item_size, sizeof(bgi));
>  		return -EUCLEAN;
>  	}
> 
