Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1199880-1519729430-2-13700134886885807675
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519729429; b=i6SmsmGlQ7MfSmXTvP44UjLJ4Y14mg3yQmiFNdmD40jKTOg
    OsKW764HpXbcR0x4cchD1JuSkM4Crfhrcp/yuvWi2DAHB+D6v4l5fsmmJDguK1hE
    X1OVkm+EPemM+cIEUDAY7E815yBdVipd65Eg7+F+ww8hNj6xGiL/qs5iejvVlEPG
    ek1LKPSlsLmeuBZ2O/XZpmujbJ86lDKstG1KRPMmMI3XspUNBaayOUFJ8k9bllgL
    lacVqkFzUitOJrLbQfdHG5dX0Gr31WtAzZtfSgF3ERu8GvXvltLr9LLqsWpOs1oL
    bZwWHTm9ky6MJFX8Z4Fm+MK52T3qqsHbKKf31Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1519729429; bh=lx6wgmOZ
    SgQ/GvgVM3bdXX3AnqqPxS6E3GkMLfJfgpk=; b=OaErfnoDwwrgaopiai8K4aM1
    x5sRW5kiW/FRRoEEJc2ahSn6hE8HW2QGy/nUbXD+3X8DjfJmbo59Nus3gEjxktf6
    SYIF2n7rl8zHm4jcSltb7ggfxzGG68MOAPJJ+lghlO8nYhtlWvTQSGEdUrydu6jk
    m++5igChRfhE5FBom2bzN15EbTJfra83z15S8o0siwUPA+7/3s7XnwODRwwCYulg
    ME0iP+ydJOXjCVAc1J01DHiG07rF2A8Bz/hjlOS0gcbeA0aHkdEQV9lLU+c3Ie3W
    BcgkWc72JHLG46ENSJHdtvPpLHGmav4lmOo7HuIf4gp124mJ/baeyGIL10qNug==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=uZPb5NKB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=uZPb5NKB x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbeB0LDS (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 06:03:18 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:25507 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752185AbeB0LDP (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 06:03:15 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180227110313epoutp039bbe71c0cd962b0457b70b2c62cc11e9~XKdTci4RA0259002590epoutp03H
X-AuditID: b6c32a38-ac3ff70000001054-c5-5a953af0e051
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A953AF2.6030501@samsung.com>
Date: Tue, 27 Feb 2018 20:03:14 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andrzej Hajda <a.hajda@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 5/6] extcon: add possibility to get extcon device by
 OF node
In-reply-to: <20180227071134.28063-6-a.hajda@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAJsWRmVeSWpSXmKPExsWy7bCmru5Hq6lRBh/cLW6tO8dq0dTxltVi
        44z1rBbzjwC5V76+Z7OYdH8Ci8X58xvYLTonLmG32PT4GqvF5V1z2CxmnN/HZLFoWSuzxdoj
        d9ktll6/yGTRuvcIuwO/x5p5axg9Lvf1MnnM7pjJ6rFpVSebx/3u40wem5fUe/RtWcXo8XmT
        XABHVKpNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJuqq2Si0+ArltmDtDt
        SgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpWhDQyM9QwNzPSMjIz0T41grI1OgkoTUjMsv
        brIWNMtVLJl6mqmB8YhEFyMnh4SAicTUy9vYuhi5OIQEdjBKPDt8Acr5zihx9clWdpiqE082
        MUMkdjNKXOg/wwSS4BUQlPgx+R5LFyMHB7OAvMSRS9kgYWYBTYmtu9ezQ9TfY5Q4vP8LVL2W
        xJkZhxhBbBYBVYnDd66zgthsQPH9L26wgdj8AooSV388BqsRFYiQ2Dn/G9ggEYEWRokdzctY
        QBxmgWYWiU1PFzCBbBYWCJVYv50FpIFTwFJi955rYDUSAqvYJSZ2bwO7TkLAReJ2C9TPwhKv
        jm9hhwhLS1w6agtR3s4o0b53HjOEM4VR4tz1e0wQDcYSzxZ2MUG8xifx7msPK0Qzr0RHmxBE
        iYfEr997mCFsR4nn6zvAngGH1o0t6hMY5WYhhdcsRHjNQgqvBYzMqxjFUguKc9NTiw0LTPSK
        E3OLS/PS9ZLzczcxglOrlsUOxj3nfA4xCnAwKvHwzpCbEiXEmlhWXJl7iFGCg1lJhHfl4slR
        QrwpiZVVqUX58UWlOanFhxhNgcE9kVlKNDkfmPbzSuINTSwNTMyMgMnL0tBQSZw3IMAlSkgg
        PbEkNTs1tSC1CKaPiYNTqoHRpmlmOn+9XmjvotcJq4x0LX7eSFRazPT1tYvU48rtsvNuZW/S
        3JOUvfTAXfbN9j9CTsbGb8h4tPaAV46xgNFRFtWQuTUHZKYmCrgmLtA4VxCxX0Pl6r6iY3nc
        LFdNxS5Vc4S+1VZfXpC02veFc7rt7T2/7E5s2CZ8qdZyQ6nS3qNMvxapny9XYinOSDTUYi4q
        TgQANzwLM8MDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprGIsWRmVeSWpSXmKPExsVy+t9jAd0PVlOjDPZ9Vra4te4cq0VTx1tW
        i40z1rNazD8C5F75+p7NYtL9CSwW589vYLfonLiE3WLT42usFpd3zWGzmHF+H5PFomWtzBZr
        j9xlt1h6/SKTReveI+wO/B5r5q1h9Ljc18vkMbtjJqvHplWdbB73u48zeWxeUu/Rt2UVo8fn
        TXIBHFFcNimpOZllqUX6dglcGZdf3GQtaJarWDL1NFMD4xGJLkZODgkBE4kTTzYxdzFycQgJ
        7GSUmPjnGitIgldAUOLH5HssXYwcHMwC8hJHLmWDhJkF1CUmzVsEVf+AUeLVRJBmkHotiTMz
        DjGC2CwCqhKH71wHm8MGFN//4gYbiM0voChx9cdjRpCZogIREt0nKkHmiAi0MUpsn7GLEcRh
        FmhmkeicdY8JpEFYIFRi1/FJrBDbdjNK3Nl7kB0kwSlgKbF7zzWWCYwCs5AcOwvh2FlIjl3A
        yLyKUTK1oDg3PbfYqMAwL7Vcrzgxt7g0L10vOT93EyMwtrYd1urbwXh/SfwhRgEORiUe3hly
        U6KEWBPLiitzDzFKcDArifCuXDw5Sog3JbGyKrUoP76oNCe1+BCjNAeLkjjv7bxjkUIC6Ykl
        qdmpqQWpRTBZJg5OqQbGjmvP2FZPOjbpyfWcHbffTPVoyDl/UTD8g/iOrCSG5Sv36R55v0WE
        cx1zyNydPPc7f7y437LNynH1sfp4yxfHgi3d/zVemGBRXKNecrLzZ5do68erG1sVn18ImZml
        cbnEI+Hn7SfBu29zLnsjuyzk16v7Inc/KsqtqQ/8P5G/csePP7dZCp98bVRiKc5INNRiLipO
        BACxauhRqQIAAA==
X-CMS-MailID: 20180227110312epcas1p137829275737ecf19f45ab2456fd8151a
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071141eucas1p1170216070d70007a07de120a0dc3363a
X-RootMTR: 20180227071141eucas1p1170216070d70007a07de120a0dc3363a
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071141eucas1p1170216070d70007a07de120a0dc3363a@eucas1p1.samsung.com>
        <20180227071134.28063-6-a.hajda@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 2018년 02월 27일 16:11, Andrzej Hajda wrote:
> Since extcon property is not allowed in DT, extcon subsystem requires
> another way to get extcon device. Lets try the simplest approach - get
> edev by of_node.
> 
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
> v5: function renamed to extcon_find_edev_by_node (Andy)
> v2: changed label to follow local convention (Chanwoo)
> ---
>  drivers/extcon/extcon.c | 44 ++++++++++++++++++++++++++++++++++----------
>  include/linux/extcon.h  |  6 ++++++
>  2 files changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c
> index cb38c2747684..47a5ca9eb86d 100644
> --- a/drivers/extcon/extcon.c
> +++ b/drivers/extcon/extcon.c
> @@ -1336,6 +1336,28 @@ void extcon_dev_unregister(struct extcon_dev *edev)
>  EXPORT_SYMBOL_GPL(extcon_dev_unregister);
>  
>  #ifdef CONFIG_OF
> +
> +/*
> + * extcon_find_edev_by_node - Find the extcon device from devicetree.
> + * @node	: OF node identyfying edev

s/identyfying/identifying

> + *
> + * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
> + */
> +struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
> +{
> +	struct extcon_dev *edev;
> +
> +	mutex_lock(&extcon_dev_list_lock);
> +	list_for_each_entry(edev, &extcon_dev_list, entry)
> +		if (edev->dev.parent && edev->dev.parent->of_node == node)
> +			goto out;
> +	edev = ERR_PTR(-EPROBE_DEFER);
> +out:
> +	mutex_unlock(&extcon_dev_list_lock);
> +
> +	return edev;
> +}
> +
>  /*
>   * extcon_get_edev_by_phandle - Get the extcon device from devicetree.
>   * @dev		: the instance to the given device
> @@ -1363,25 +1385,27 @@ struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
>  		return ERR_PTR(-ENODEV);
>  	}
>  
> -	mutex_lock(&extcon_dev_list_lock);
> -	list_for_each_entry(edev, &extcon_dev_list, entry) {
> -		if (edev->dev.parent && edev->dev.parent->of_node == node) {
> -			mutex_unlock(&extcon_dev_list_lock);
> -			of_node_put(node);
> -			return edev;
> -		}
> -	}
> -	mutex_unlock(&extcon_dev_list_lock);
> +	edev = extcon_find_edev_by_node(node);
>  	of_node_put(node);
>  
> -	return ERR_PTR(-EPROBE_DEFER);
> +	return edev;
>  }
> +
>  #else
> +
> +struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
> +{
> +	return ERR_PTR(-ENOSYS);
> +}
> +
>  struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev, int index)
>  {
>  	return ERR_PTR(-ENOSYS);
>  }
> +
>  #endif /* CONFIG_OF */
> +
> +EXPORT_SYMBOL_GPL(extcon_find_edev_by_node);
>  EXPORT_SYMBOL_GPL(extcon_get_edev_by_phandle);
>  
>  /**
> diff --git a/include/linux/extcon.h b/include/linux/extcon.h
> index 6d94e82c8ad9..7f033b1ea568 100644
> --- a/include/linux/extcon.h
> +++ b/include/linux/extcon.h
> @@ -230,6 +230,7 @@ extern void devm_extcon_unregister_notifier_all(struct device *dev,
>   * Following APIs get the extcon_dev from devicetree or by through extcon name.
>   */
>  extern struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name);
> +extern struct extcon_dev *extcon_find_edev_by_node(struct device_node *node);
>  extern struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
>  						     int index);
>  
> @@ -283,6 +284,11 @@ static inline struct extcon_dev *extcon_get_extcon_dev(const char *extcon_name)
>  	return ERR_PTR(-ENODEV);
>  }
>  
> +static inline struct extcon_dev *extcon_find_edev_by_node(struct device_node *node)
> +{
> +	return ERR_PTR(-ENODEV);
> +}
> +
>  static inline struct extcon_dev *extcon_get_edev_by_phandle(struct device *dev,
>  				int index)
>  {
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
