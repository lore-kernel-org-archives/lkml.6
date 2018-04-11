Return-Path: <admin@hostcenter.eu>
X-Google-Smtp-Source: AIpwx49sQ2N6pAf3qr7yMyWIWQX368I8Pr76gWFHxpGZ+RGuVHkOjawUmOvRB48c5IH6hsnvJ1t4
ARC-Seal: i=1; a=rsa-sha256; t=1523442782; cv=none;
        d=google.com; s=arc-20160816;
        b=FrL4PI+39+mMGn1u6/vetWC/Jx9r2vfy/yRYm+VfBhyFB34Vee0c4J5VuBxpAF84ku
         fatF8qnTulBhxpQYE9OvvVcReOKkoRsJhymQxrVQ+mb9BgpwtAOschu8tmSEZvU1hvOi
         JOxXzesQyBSLMIGTi32jqAlcXXpx6/WW63TzMrW9ZmCHLRErs4gDATI983op0pYgBzt3
         EB/fFoRq5bWB3Uf3sSO8ubXIJ2ZrUGB50Q/dkx3XE+80gyd28ykXYDHop/xwkuRcYXNx
         fn2W28v9QlisZLh4kPrzGHLiNkPCSfxFDw1fooRIt0dD4ei/hm92kH15oFkaWqbU0reG
         5tOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:disposition-notification-to:return-receipt-to
         :references:in-reply-to:subject:cc:to:from:date
         :content-transfer-encoding:mime-version:dkim-signature
         :arc-authentication-results;
        bh=cb1MRMZnXlf6i/wWAuKIaeru9N/1+XJ/T2t7uWQthZU=;
        b=iftFk1v1IvVSYHklDUSzjPfgvPe3KAjCMZB+6yhKGJ9OavFs+e9Rowv/LLJdyZ9JYv
         LPRWQDxtMIgXLPq0kawMGEgU7COspmjt2r1gOXayI53u50Z344lTu0rcwpUQ29WH3Acr
         c5pvW1YJCBQjDLNSMnLfE7ERJGO1UImVEd/Zo8jTVDZfmFfYQ/xD74LTV9XoNu6CBzg5
         IHXTXBJxixsgwGAeOMV9N68Erf8uNretpUzeHgyZDMQhF1HzcmuWxhGcgb1bxX30Zd4B
         N1K3vtUXxVu2Br1MkYk7bSH9qETCBGYSIAYNCoLx+xuE7Y0aWhtVuJm+JBm6yLy4JUGv
         CAjg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@hostcenter.eu header.s=mail header.b=g3fAGjaE;
       spf=pass (google.com: domain of admin@hostcenter.eu designates 195.136.231.201 as permitted sender) smtp.mailfrom=admin@hostcenter.eu;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=hostcenter.eu
Authentication-Results: mx.google.com;
       dkim=pass header.i=@hostcenter.eu header.s=mail header.b=g3fAGjaE;
       spf=pass (google.com: domain of admin@hostcenter.eu designates 195.136.231.201 as permitted sender) smtp.mailfrom=admin@hostcenter.eu;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=hostcenter.eu
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date: Wed, 11 Apr 2018 12:33:00 +0200
From: admin@hostcenter.eu
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Cong Wang
 <xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.15/4.16 150/168] net_sched: fix a missing idr_remove()
 in u32_delete_key()
In-Reply-To: <20180410212807.458895663@linuxfoundation.org>
References: <20180410212800.144079021@linuxfoundation.org>
 <20180410212807.458895663@linuxfoundation.org>
X-Priority: 5 (Lowest)
Message-ID: <5d2a78ed10fc0d81c0bf8839c7fed217@hostcenter.eu>
User-Agent: Roundcube Webmail/1.2.5
X-Remote-Browser: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:59.0)
 Gecko/20100101 Firefox/59.0
X-Originating-IP: [193.93.90.11]
X-RoundCube-Server: 195.136.231.201
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597399704522433774?=
X-GMAIL-MSGID: =?utf-8?q?1597445538451469818?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

W dniu 2018-04-11 00:24, Greg Kroah-Hartman napisał(a):
> 4.15-stable review patch.  If anyone has any objections, please let me 
> know.
> 
> ------------------
> 
> From: Cong Wang <xiyou.wangcong@gmail.com>
> 
> 
> [ Upstream commit f12c643209db0626f2f54780d86bb93bfa7a9c2d ]
> 
> When we delete a u32 key via u32_delete_key(), we forget to
> call idr_remove() to remove its handle from IDR.
> 
> Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter 
> handles")
> Reported-by: Marcin Kabiesz <admin@hostcenter.eu>
> Tested-by: Marcin Kabiesz <admin@hostcenter.eu>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/sched/cls_u32.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/net/sched/cls_u32.c
> +++ b/net/sched/cls_u32.c
> @@ -478,6 +478,7 @@ static int u32_delete_key(struct tcf_pro
>  				RCU_INIT_POINTER(*kp, key->next);
> 
>  				tcf_unbind_filter(tp, &key->res);
> +				idr_remove(&ht->handle_idr, key->handle);
>  				tcf_exts_get_net(&key->exts);
>  				call_rcu(&key->rcu, u32_delete_key_freepf_rcu);
>  				return 0;

Hello,
Thank you for the correction. If you had a problem or was not sure, 
please speak. I will try to test new changes or give relevant 
information on how to best test this. I have experience in this because 
I am currently working on the configuration of routers and in this cut 
QoS band.

Thank you again for making the correction.  :)

Best Regards
Marcin Kabiesz
