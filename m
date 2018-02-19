Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1293483-1519083366-2-16782705459706230787
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519083365; b=SnHerysx4mg6wgjOtDQKQstyeuWACuuwsP4aEYtybXq6uUZ
    rkNjLCm87S9B7798m6wR7wz/XAfqMLqphnheUw2xGJC/oFoI8/slCrhy3k3FbtEr
    cIm2IfqLg972KdE2Wx2RwGrPlseQ6L0016o1JcTBI+VDjbabqBV0by1vHZ0eTz9A
    dsSeAkuqP84Ah486lhDq719y8YgCTHrEhuyMimaHscyB5/lDwz8mA7CunVCXJhX2
    VxaCVweofxw7JWPgDx3kjRYWdHXG7cP2lfC0vdS/EyOen1K0aN/6GRx12s2SQKzG
    DO1VK18nzg7UQ6LtNjvyejMQhXmV9DA7nghNh8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1519083365; bh=YgSeYllu
    lQKqWeuotEhdYx8zxtFIYkZ11oERwm/eGd8=; b=DUGkbiwAohARVuB36/g19vDh
    RCCvyvGmeYvD3/eOWidsj6mkirYjLpmgTMF6i9ADYKwUh6r7TicOWHT0CKJQLE+B
    L6knBwEzhqjNeBsXTWj+12BWCbt2wYj+TP22ZhgOflIW5XkGgU1WeBRjfiqvtMrP
    Kdw0GEFqb3hF7/qsrQK8tr9sPtL2ql5XnJeTIFfaT0Y2nHpWOxb1LMxyQkAPmaYC
    Sg6EfqMUl3Xyr103Ptw3I90ml7TfIyxBJ+zgUbqycDBFwqWqqHmrY42Bftc2ctLt
    wvcfz4c6jJS8JgM5ZIKfABuLzhaIJf3T0v0+vbinbpdZ0QagpKOQopX/LHXcXQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=S4FLZt2V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=S4FLZt2V x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932232AbeBSXgC (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 18:36:02 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:20583 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932205AbeBSXgB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Feb 2018 18:36:01 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180219233559epoutp04f351f853fa7e9121bf73ddfdb7163754~U3kRBmBcF1783217832epoutp04J
X-AuditID: b6c32a47-187ff7000000100c-00-5a8b5f5e1dde
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A8B5F5D.8090208@samsung.com>
Date: Tue, 20 Feb 2018 08:35:57 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] extcon: intel-cht-wc: Also set direction and drv
 flags for V5 boost GPIO
In-reply-to: <20180219132046.13450-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7bCmmW5cfHeUwdo78hZvjk9nsri8aw6b
        xe3GFWwWCzY+YnRg8Xi/7yqbR9+WVYwenzfJBTBHpdpkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        RRsaGukZGpjrGRkZ6ZkYx1oZmQKVJKRmtP3ZwFwwSaDi6rZlLA2ME3m7GDk5JARMJNa/us/Y
        xcjFISSwg1Fiw8Q9UM53Roneu99Yuxg5wKoaJvNCxHczSrS9v8sE0s0rICjxY/I9FpAaZgF5
        iSOXskHCzAKaElt3r2cHsYUE7jFKTH3ECVGuJfFk4iZmEJtFQFXi0furYDYbUHz/ixtsIDa/
        gKLE1R+PGUFsUYEIiZ3zv4HNEREIkrjxfQUrxCoLifb9piBhYYEkiW+nmphAwpwClhKdl1VB
        rpQQWMEmcffyXlaIH10kFl+dzwJhC0u8Or6FHcKWlni2aiMjREM7o0T73nnMEM4URolz1+8x
        QVQZSzxb2MUE8RifRMfhv+yQMOGV6GgTgijxkFjxdCEbhO0osWDfB2ZIWPUwSuz6+J5xAqPc
        LKTgmoUIrllIwbWAkXkVo1hqQXFuemqxUYGxXnFibnFpXrpecn7uJkZw6tJy38G47ZzPIUYB
        DkYlHt4dt7qihFgTy4orcw8xSnAwK4nw5oh0RwnxpiRWVqUW5ccXleakFh9iNAUG90RmKdHk
        fGBazSuJNzSxNDAxMzMyN7MAJi9x3tYAlyghgfTEktTs1NSC1CKYPiYOTqkGxpOHJ/5T4ctW
        8TtY+fJ48O/Fn/8zXdqa9OFwMsM33fgEO2ZejWvV1/qqJyfmlN93F9T5nHLk+Y1/u3zseCQb
        PHoDtytWvzzIdcldpMhrtnPWk4XbM9ulvt7acsj6ygsrB8+9RY8PTI8X+Hsp/ev29mfvkxxq
        HbR5OkX+rLS45faya/cri6WNhkosxRmJhlrMRcWJALwsk/hzAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t9jAd3Y+O4ogynvrC3eHJ/OZHF51xw2
        i9uNK9gsFmx8xOjA4vF+31U2j74tqxg9Pm+SC2CO4rJJSc3JLEst0rdL4Mpo+7OBuWCSQMXV
        bctYGhgn8nYxcnBICJhINEwGMrk4hAR2Mko07VzM1MXIycErICjxY/I9FpAaZgF5iSOXskHC
        zALqEpPmLWKGqH/AKPHz0xRWiHotiScTNzGD2CwCqhKP3l8Fs9mA4vtf3GADsfkFFCWu/njM
        CDJTVCBCovtEJUhYRCBA4uepfnaIVRYS7ftNQcLCAkkSS+/fZ4FY1ccocfHJZyaQGk4BS4nO
        y6oTGAVmITl0FsKhs5AcuoCReRWjZGpBcW56brFRgVFearlecWJucWleul5yfu4mRmDIbjus
        1b+D8fGS+EOMAhyMSjy8Ane7ooRYE8uKK3MPMUpwMCuJ8OaIdEcJ8aYkVlalFuXHF5XmpBYf
        YpTmYFES5+XPPxYpJJCeWJKanZpakFoEk2Xi4JRqYNTYfCfN1PfPpv89JRmLHwX9ePGmeIlX
        nIfshamW88Lv5mmtLVQ9w20nZMv5ZEOeTKJmwtnF579EPmCdePfPjCN90rHbn8xf8aDr5rtP
        G+5NWpW+y0n02opNknfMmN53nDCsmJIR8uBRl1FZs7N9loFj/KsJLaeyox7bdvs+fLmDUd2a
        /fPp1UeUWIozEg21mIuKEwFeNXFqVQIAAA==
X-CMS-MailID: 20180219233558epcas2p2796b0c5a22082f3ab126bc4132232e9d
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180219132056epcas4p3e883323c9a91d1039dedd8a98806e85e
X-RootMTR: 20180219132056epcas4p3e883323c9a91d1039dedd8a98806e85e
References: <CGME20180219132056epcas4p3e883323c9a91d1039dedd8a98806e85e@epcas4p3.samsung.com>
        <20180219132046.13450-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018년 02월 19일 22:20, Hans de Goede wrote:
> Sometimes (firmware bug?) the V5 boost GPIO is not configured as output
> by the BIOS, leading to the 5V boost convertor being permanently on,
> 
> Explicitly set the direction and drv flags rather then inheriting them
> from the firmware to fix this.
> 
> Fixes: 585cb239f4de ("extcon: intel-cht-wc: Disable external 5v boost ...")
> Cc: stable@vger.kernel.org
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add Fixes tag and Cc: stable
> ---
>  drivers/extcon/extcon-intel-cht-wc.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/extcon-intel-cht-wc.c
> index 7c4bc8c44c3f..b7e9ea377d70 100644
> --- a/drivers/extcon/extcon-intel-cht-wc.c
> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> @@ -66,6 +66,8 @@
>  
>  #define CHT_WC_VBUS_GPIO_CTLO		0x6e2d
>  #define CHT_WC_VBUS_GPIO_CTLO_OUTPUT	BIT(0)
> +#define CHT_WC_VBUS_GPIO_CTLO_DRV_OD	BIT(4)
> +#define CHT_WC_VBUS_GPIO_CTLO_DIR_OUT	BIT(5)
>  
>  enum cht_wc_usb_id {
>  	USB_ID_OTG,
> @@ -183,14 +185,15 @@ static void cht_wc_extcon_set_5v_boost(struct cht_wc_extcon_data *ext,
>  {
>  	int ret, val;
>  
> -	val = enable ? CHT_WC_VBUS_GPIO_CTLO_OUTPUT : 0;
> -
>  	/*
>  	 * The 5V boost converter is enabled through a gpio on the PMIC, since
>  	 * there currently is no gpio driver we access the gpio reg directly.
>  	 */
> -	ret = regmap_update_bits(ext->regmap, CHT_WC_VBUS_GPIO_CTLO,
> -				 CHT_WC_VBUS_GPIO_CTLO_OUTPUT, val);
> +	val = CHT_WC_VBUS_GPIO_CTLO_DRV_OD | CHT_WC_VBUS_GPIO_CTLO_DIR_OUT;
> +	if (enable)
> +		val |= CHT_WC_VBUS_GPIO_CTLO_OUTPUT;
> +
> +	ret = regmap_write(ext->regmap, CHT_WC_VBUS_GPIO_CTLO, val);
>  	if (ret)
>  		dev_err(ext->dev, "Error writing Vbus GPIO CTLO: %d\n", ret);
>  }
> 

Applied it to extcon-fixes branch.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
