Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CF5ECE566
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C82CB20858
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 23:36:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mvZGR0tP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C82CB20858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbeITFQ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 01:16:57 -0400
Received: from sonic306-10.consmr.mail.bf2.yahoo.com ([74.6.132.49]:41833 "EHLO
        sonic306-10.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733138AbeITFQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 01:16:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1537400197; bh=4rwgRFA0Gai7YlZQ/2/vAspvddmefEO+kxAt0ov1m9k=; h=Subject:To:References:From:Date:In-Reply-To:From:Subject; b=mvZGR0tPI5+lS/pfMBCD8TTLHCoxmaTufU6AyMwGpmeINqxMNhTVW9TM7InVfABM5pCF4alV9fR0nc1Su0R0fT6bjF6M6M5rd/FH3ciIF1SoUSG/AzEG1gVEsdhfR/2XbPhnBBIVLo1d1R4QKsJcDntNGUQEk7d1pCBiMjWcZFBU8nTbfJhdALd+AYLlY3V6krgnINy7Klf9fwEedHtoQS23ZCh6mSjtlAQ2xHuurpJIu0+XHxrztK69roKQFd1kSjQiNUQctwhYrepIyh7SLcD7zz2IdVhNSJPkub67J7/liPE9tWFCHR9V6wXIk5mP8t/LbLE99OUdAyYXb9Jnqw==
X-YMail-OSG: HPELvZ8VM1nweiXWSH1bk0WwPIp6HeOhEwqqI..B14JpMyEpDIZr50.9RCdF8Cb
 SUReRtS_jGW3GY2O4KCWiRQoFP6Tzcv9pKvG.Nm0ZvI_SV5ght.pHgCUvMOAvE6qPBTQEdh9Yc_P
 8_5CZHI8Oyf5dvBThtAiOv0tRdntSrhA72uwZiv31Hjk.K8lV.h1MEuPB3fsKGICSCuCd2umKWNY
 mJKMuhRiQSfxfbueyHy_guBVA2P7qp41ApmcgCNBktkLCMIKieZMkZPEF1iYEaRNjchIi2yUJyIs
 Ry0Odfta4FSMbj.B4M_2P9PuDYCw8Hf2bhml5ub64WtD2VNDVQL6g0KMasbQFhVlabRRaqf43mGe
 DPghYJjD8qiuYU56p5DfG3bjWHNNAxmitwY_CApMvAyovGdlvRpDiTLUYWO1OjPY32haddEJlo7r
 HmYZSYOh14J3Be.QSkDhcuzcHgn1y4uydffPNI5zqHCX5DUhFVXVSAPckjCz9_sM2iHeCpoLyZWt
 LsSOFtqbotXax77btWqDiX2mVI2GdkBpFz1ba1RTaRijBTR4wYqge1tcXdbhxvUxZsR7LOznMPu0
 IAaba_3x3uXILFSLR2Oi9pf3JfE8e47024T6eybpkAAQ2da_G7npU2iplwXGISPakH80LDfACi7i
 Pi6aL4jMfccEpl8qLP_6Men3ns5DEUiPiMGEsu7FODpyLDdgVjHGUe3kWzc0z7UOAbHjv5RwuR4y
 SdnEFy_2dL3if097rrsLIzzSnt9fkZ0IsbjLen.mUoKqj1EMPfxMuP_In5HEVg3QXz_fD.D82Fnt
 kS9e4vH81k.gTgr3HaPCoJHZ8Tc1_7jevDEDVMmv75rEY9nBCyfAxtWMnk0mHb9C3dOi2l6FYE6V
 N6fA3tbw.IomR8BgulHAmVnadNvt3qjjMiAZ91W2VUde5cGbKWhdN0Ij7KFJwxM4hjOQkgxFkXcG
 wojm7_BIAnXfyM6Q6NJ_uvqEuiVKjGhRTL714hWiyhBlxKj0SgjvtWaKJhyLdJNgJtiwvSHIP2nK
 T8zQzaXhHqSucHnFhPgKs6ucAr7W2ww--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Wed, 19 Sep 2018 23:36:37 +0000
Received: from c-67-169-65-224.hsd1.ca.comcast.net (EHLO [192.168.0.102]) ([67.169.65.224])
          by smtp422.mail.bf1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 9b402c442a2b643b8390abf1681d5e1c;
          Wed, 19 Sep 2018 23:36:36 +0000 (UTC)
Subject: Re: [PATCH] netfilter: nf_tables: add SECMARK support
To:     =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de,
        davem@davemloft.net, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@paul-moore.com,
        sds@tycho.nsa.gov, eparis@parisplace.org, jmorris@namei.org,
        serge@hallyn.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org
References: <20180919231402.4482-1-cgzones@googlemail.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Message-ID: <75b3fed9-e549-4ed0-c435-ec4795fc1e39@schaufler-ca.com>
Date:   Wed, 19 Sep 2018 16:36:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180919231402.4482-1-cgzones@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/2018 4:14 PM, Christian Göttsche wrote:
> Add the ability to set the security context of packets within the nf_tables framework.
> Add a nft_object for holding security contexts in the kernel and manipulating packets on the wire.
> The contexts are kept as strings and are evaluated to security identifiers at runtime (packet arrival),
> so that the nft_objects do not need to be refreshed after security changes.
> The maximum security context length is set to 256.
>
> Based on v4.18.6
>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

I've only had a cursory look at your patch, but how is it
different from what's in xt_SECMARK.c ?

> ---
>  include/net/netfilter/nf_tables_core.h   |  4 +
>  include/uapi/linux/netfilter/nf_tables.h | 18 ++++-
>  net/netfilter/nf_tables_core.c           | 28 ++++++-
>  net/netfilter/nft_meta.c                 | 95 ++++++++++++++++++++++++
>  4 files changed, 140 insertions(+), 5 deletions(-)
>
> diff --git a/include/net/netfilter/nf_tables_core.h b/include/net/netfilter/nf_tables_core.h
> index a0513450..0d1f3b96 100644
> --- a/include/net/netfilter/nf_tables_core.h
> +++ b/include/net/netfilter/nf_tables_core.h
> @@ -16,6 +16,10 @@ extern struct nft_expr_type nft_meta_type;
>  extern struct nft_expr_type nft_rt_type;
>  extern struct nft_expr_type nft_exthdr_type;
>  
> +#ifdef CONFIG_NETWORK_SECMARK
> +extern struct nft_object_type nft_secmark_obj_type;
> +#endif
> +
>  int nf_tables_core_module_init(void);
>  void nf_tables_core_module_exit(void);
>  
> diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
> index 89438e68..f1527962 100644
> --- a/include/uapi/linux/netfilter/nf_tables.h
> +++ b/include/uapi/linux/netfilter/nf_tables.h
> @@ -1169,6 +1169,21 @@ enum nft_quota_attributes {
>  };
>  #define NFTA_QUOTA_MAX		(__NFTA_QUOTA_MAX - 1)
>  
> +/**
> + * enum nft_secmark_attributes - nf_tables secmark object netlink attributes
> + *
> + * @NFTA_SECMARK_CTX: security context (NLA_STRING)
> + */
> +enum nft_secmark_attributes {
> +	NFTA_SECMARK_UNSPEC,
> +	NFTA_SECMARK_CTX,
> +	__NFTA_SECMARK_MAX,
> +};
> +#define NFTA_SECMARK_MAX	(__NFTA_SECMARK_MAX - 1)
> +
> +/* Max security context length */
> +#define NFT_SECMARK_CTX_MAXLEN		256
> +
>  /**
>   * enum nft_reject_types - nf_tables reject expression reject types
>   *
> @@ -1398,7 +1413,8 @@ enum nft_ct_helper_attributes {
>  #define NFT_OBJECT_CT_HELPER	3
>  #define NFT_OBJECT_LIMIT	4
>  #define NFT_OBJECT_CONNLIMIT	5
> -#define __NFT_OBJECT_MAX	6
> +#define NFT_OBJECT_SECMARK	6
> +#define __NFT_OBJECT_MAX	7
>  #define NFT_OBJECT_MAX		(__NFT_OBJECT_MAX - 1)
>  
>  /**
> diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
> index 8de912ca..d59ebba0 100644
> --- a/net/netfilter/nf_tables_core.c
> +++ b/net/netfilter/nf_tables_core.c
> @@ -235,12 +235,24 @@ static struct nft_expr_type *nft_basic_types[] = {
>  	&nft_exthdr_type,
>  };
>  
> +static struct nft_object_type *nft_basic_objects[] = {
> +#ifdef CONFIG_NETWORK_SECMARK
> +	&nft_secmark_obj_type,
> +#endif
> +};
> +
>  int __init nf_tables_core_module_init(void)
>  {
> -	int err, i;
> +	int err, i, j = 0;
> +
> +	for (i = 0; i < ARRAY_SIZE(nft_basic_objects); i++) {
> +		err = nft_register_obj(nft_basic_objects[i]);
> +		if (err)
> +			goto err;
> +	}
>  
> -	for (i = 0; i < ARRAY_SIZE(nft_basic_types); i++) {
> -		err = nft_register_expr(nft_basic_types[i]);
> +	for (j = 0; j < ARRAY_SIZE(nft_basic_types); j++) {
> +		err = nft_register_expr(nft_basic_types[j]);
>  		if (err)
>  			goto err;
>  	}
> @@ -248,8 +260,12 @@ int __init nf_tables_core_module_init(void)
>  	return 0;
>  
>  err:
> +	while (j-- > 0)
> +		nft_unregister_expr(nft_basic_types[j]);
> +
>  	while (i-- > 0)
> -		nft_unregister_expr(nft_basic_types[i]);
> +		nft_unregister_obj(nft_basic_objects[i]);
> +
>  	return err;
>  }
>  
> @@ -260,4 +276,8 @@ void nf_tables_core_module_exit(void)
>  	i = ARRAY_SIZE(nft_basic_types);
>  	while (i-- > 0)
>  		nft_unregister_expr(nft_basic_types[i]);
> +
> +	i = ARRAY_SIZE(nft_basic_objects);
> +	while (i-- > 0)
> +		nft_unregister_obj(nft_basic_objects[i]);
>  }
> diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
> index 1105a23b..26b79a3c 100644
> --- a/net/netfilter/nft_meta.c
> +++ b/net/netfilter/nft_meta.c
> @@ -540,3 +540,98 @@ struct nft_expr_type nft_meta_type __read_mostly = {
>  	.maxattr	= NFTA_META_MAX,
>  	.owner		= THIS_MODULE,
>  };
> +
> +#ifdef CONFIG_NETWORK_SECMARK
> +
> +struct nft_secmark {
> +	char ctx[NFT_SECMARK_CTX_MAXLEN];
> +	int len;
> +};
> +
> +static const struct nla_policy nft_secmark_policy[NFTA_SECMARK_MAX + 1] = {
> +	[NFTA_SECMARK_CTX]     = { .type = NLA_STRING, .len = NFT_SECMARK_CTX_MAXLEN },
> +};
> +
> +
> +static void nft_secmark_obj_eval(struct nft_object *obj, struct nft_regs *regs, const struct nft_pktinfo *pkt)
> +{
> +	const struct nft_secmark *priv = nft_obj_data(obj);
> +	struct sk_buff *skb = pkt->skb;
> +	int err;
> +	u32 secid = 0;
> +
> +	/* skip if packet has already a secmark */
> +	if (skb->secmark)
> +		return;
> +
> +	err = security_secctx_to_secid(priv->ctx, priv->len, &secid);
> +	if (err) {
> +		if (err == -EINVAL)
> +			pr_notice_ratelimited("invalid security context \'%s\'\n", priv->ctx);
> +		else
> +			pr_notice_ratelimited("unable to convert security context \'%s\': %d\n", priv->ctx, -err);
> +		return;
> +	}
> +
> +	if (!secid) {
> +		pr_notice_ratelimited("unable to map security context \'%s\'\n", priv->ctx);
> +		return;
> +	}
> +
> +	err = security_secmark_relabel_packet(secid);
> +	if (err) {
> +		pr_notice_ratelimited("unable to obtain relabeling permission: %d\n", -err);
> +		return;
> +	}
> +
> +	skb->secmark = secid;
> +}
> +
> +
> +static int nft_secmark_obj_init(const struct nft_ctx *ctx, const struct nlattr * const tb[], struct nft_object *obj)
> +{
> +	struct nft_secmark *priv = nft_obj_data(obj);
> +
> +	if (tb[NFTA_SECMARK_CTX] == NULL)
> +		return -EINVAL;
> +
> +	nla_strlcpy(priv->ctx, tb[NFTA_SECMARK_CTX], NFT_SECMARK_CTX_MAXLEN);
> +	priv->len = strlen(priv->ctx);
> +
> +	security_secmark_refcount_inc();
> +
> +	return 0;
> +}
> +
> +static int nft_secmark_obj_dump(struct sk_buff *skb, struct nft_object *obj, bool reset)
> +{
> +	const struct nft_secmark *priv = nft_obj_data(obj);
> +
> +	if (nla_put_string(skb, NFTA_SECMARK_CTX, priv->ctx))
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void nft_secmark_obj_destroy(const struct nft_ctx *ctx, struct nft_object *obj)
> +{
> +	security_secmark_refcount_dec();
> +}
> +
> +static const struct nft_object_ops nft_secmark_obj_ops = {
> +	.type		= &nft_secmark_obj_type,
> +	.size		= sizeof(struct nft_secmark),
> +	.init		= nft_secmark_obj_init,
> +	.eval		= nft_secmark_obj_eval,
> +	.dump		= nft_secmark_obj_dump,
> +	.destroy	= nft_secmark_obj_destroy,
> +};
> +struct nft_object_type nft_secmark_obj_type __read_mostly = {
> +	.type		= NFT_OBJECT_SECMARK,
> +	.ops		= &nft_secmark_obj_ops,
> +	.maxattr	= NFTA_SECMARK_MAX,
> +	.policy		= nft_secmark_policy,
> +	.owner		= THIS_MODULE,
> +};
> +
> +#endif /* CONFIG_NETWORK_SECMARK */

