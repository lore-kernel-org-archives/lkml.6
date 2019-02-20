Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78E032183F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 14:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGG3iLk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbfBTOb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 09:31:29 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43948 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfBTOb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 09:31:28 -0500
Received: by mail-ed1-f67.google.com with SMTP id m35so16051538ede.10;
        Wed, 20 Feb 2019 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lvQQ9FewI9wJrPL11MPtjS8gJ5qRj9IitPp58C2/evQ=;
        b=VGG3iLk5ddW1Ui0s7XkEfkUrtvxRXa5caEsIdfAR0OwI21ak2ieBy2Pi4RQLt6yrf2
         XGPCizi7kQt6F1oEy8AXXMVbcYxhHCnNWYDAJcKKpDSMResSU/N0O0G1xPaqhFaJvlQ2
         pNoMvflPF1HhO4VfHBzWKrpQBrbPrf/bqfcFNTl0TFagV6NrtYsynrEgAjzq5LU7Yt+F
         K41tge3HPvJPpF1YKq/d3HdzDYjCp/UsSgvQtZTd6kkXFQzPg6KPfo+ec/68vFZqoRen
         QV48/VQSDcs68aKU0RF9Aaqkzrmm0GEuDL0xscSgrkaaR/TAgfSdpkJC+8Wtm2jKNOqC
         PqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=lvQQ9FewI9wJrPL11MPtjS8gJ5qRj9IitPp58C2/evQ=;
        b=gmmLq7aM1Ho3ah2brF+DPhFbq/fmM3RfGAqhG6mTLCEvcSyl42fY4GbueMUq8fz/YP
         oc7/9ZR8anr8Qd5IJvtwOuE4j8QBHikjdbNuJ67bvnmxqRYhlbNlIXg51oTVfUD+B/IF
         +zyumKl3nBnGEA2ijUgSficF6hV3eG1d+ad989mYBVJx5A8SZnGB5qKpBkGjR+Fg3Orz
         keWTBT1dkhB3pU3CnU2cVUMZJjWkP05UCFrFRY9xcMJXoTGYRltgDzAH0pAE34vqnrjP
         n5nJzFc4od8/FWhXCI23rg80+tUOQ50Y1g0KuS7pCBCGiTTCLxTWvbM1jW1bt90rN9GK
         jL2Q==
X-Gm-Message-State: AHQUAubpwPdJWOPGLLETih2R7kyAL+SCSMzZR3405eZs5yT57H8TRllb
        /mIVbdUs9ooma/40Z73esBWk5nAl
X-Google-Smtp-Source: AHgI3IYXWOqPvLSYuDEEDbA+FUYwXIk1lwDdbsecOW3nMrRulJDfBIfoNu64Xy/+7Y1yOf4xp1ttpg==
X-Received: by 2002:a50:cf41:: with SMTP id d1mr28152891edk.242.1550673085347;
        Wed, 20 Feb 2019 06:31:25 -0800 (PST)
Received: from ziggy.stardust ([37.223.146.9])
        by smtp.gmail.com with ESMTPSA id a52sm3937693edc.74.2019.02.20.06.31.23
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 06:31:24 -0800 (PST)
Subject: Re: [PATCH v4 1/3] i2c: mediatek: Add offsets array for new i2c
 registers
To:     Qii Wang <qii.wang@mediatek.com>, wsa@the-dreams.de
Cc:     devicetree@vger.kernel.org, srv_heupstream@mediatek.com,
        robh@kernel.org, leilk.liu@mediatek.com, xinping.qian@mediatek.com,
        linux-kernel@vger.kernel.org, liguo.zhang@mediatek.com,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
 <1550666030-30211-2-git-send-email-qii.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFP1zgUBEAC21D6hk7//0kOmsUrE3eZ55kjc9DmFPKIz6l4NggqwQjBNRHIMh04BbCMY
 fL3eT7ZsYV5nur7zctmJ+vbszoOASXUpfq8M+S5hU2w7sBaVk5rpH9yW8CUWz2+ZpQXPJcFa
 OhLZuSKB1F5JcvLbETRjNzNU7B3TdS2+zkgQQdEyt7Ij2HXGLJ2w+yG2GuR9/iyCJRf10Okq
 gTh//XESJZ8S6KlOWbLXRE+yfkKDXQx2Jr1XuVvM3zPqH5FMg8reRVFsQ+vI0b+OlyekT/Xe
 0Hwvqkev95GG6x7yseJwI+2ydDH6M5O7fPKFW5mzAdDE2g/K9B4e2tYK6/rA7Fq4cqiAw1+u
 EgO44+eFgv082xtBez5WNkGn18vtw0LW3ESmKh19u6kEGoi0WZwslCNaGFrS4M7OH+aOJeqK
 fx5dIv2CEbxc6xnHY7dwkcHikTA4QdbdFeUSuj4YhIZ+0QlDVtS1QEXyvZbZky7ur9rHkZvP
 ZqlUsLJ2nOqsmahMTIQ8Mgx9SLEShWqD4kOF4zNfPJsgEMB49KbS2o9jxbGB+JKupjNddfxZ
 HlH1KF8QwCMZEYaTNogrVazuEJzx6JdRpR3sFda/0x5qjTadwIW6Cl9tkqe2h391dOGX1eOA
 1ntn9O/39KqSrWNGvm+1raHK+Ev1yPtn0Wxn+0oy1tl67TxUjQARAQABtClNYXR0aGlhcyBC
 cnVnZ2VyIDxtYXR0aGlhcy5iZ2dAZ21haWwuY29tPokCUgQTAQIAPAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AWIQTmuZIYwPLDJRwsOhfZFAuyVhMC8QUCWt3scQIZAQAKCRDZFAuy
 VhMC8WzRD/4onkC+gCxG+dvui5SXCJ7bGLCu0xVtiGC673Kz5Aq3heITsERHBV0BqqctOEBy
 ZozQQe2Hindu9lasOmwfH8+vfTK+2teCgWesoE3g3XKbrOCB4RSrQmXGC3JYx6rcvMlLV/Ch
 YMRR3qv04BOchnjkGtvm9aZWH52/6XfChyh7XYndTe5F2bqeTjt+kF/ql+xMc4E6pniqIfkv
 c0wsH4CkBHqoZl9w5e/b9MspTqsU9NszTEOFhy7p2CYw6JEa/vmzR6YDzGs8AihieIXDOfpT
 DUr0YUlDrwDSrlm/2MjNIPTmSGHH94ScOqu/XmGW/0q1iar/Yr0leomUOeeEzCqQtunqShtE
 4Mn2uEixFL+9jiVtMjujr6mphznwpEqObPCZ3IcWqOFEz77rSL+oqFiEA03A2WBDlMm++Sve
 9jpkJBLosJRhAYmQ6ey6MFO6Krylw1LXcq5z1XQQavtFRgZoruHZ3XlhT5wcfLJtAqrtfCe0
 aQ0kJW+4zj9/So0uxJDAtGuOpDYnmK26dgFN0tAhVuNInEVhtErtLJHeJzFKJzNyQ4GlCaLw
 jKcwWcqDJcrx9R7LsCu4l2XpKiyxY6fO4O8DnSleVll9NPfAZFZvf8AIy3EQ8BokUsiuUYHz
 wUo6pclk55PZRaAsHDX/fNr24uC6Eh5oNQ+v4Pax/gtyybkCDQRT9c4FARAAqdGWpdzcSM8q
 6I2oTPS5J4KXXIJS8O2jbUcxoNuaSBnUkhwp2eML/i30oLbEC+akmagcOLD0kOY46yRFeSEC
 SPM9SWLxKvKUTQYGLX2sphPVZ3hEdFYKen3+cbvo6GyYTnm8ropHM9uqmXPZFFfLJDL76Nau
 kFsRfPMQUuwMe3hFVLmF7ntvdX3Z3jKImoMWrgA/SnsT6K40n/GCl1HNz2T8PSnqAUQjvSoI
 FAenxb23NtW6kg50xIxlb7DKbncnQGGTwoYn8u9Lgxkh8gJ03IMiSDHZ9o+wl21U8B3OXr1K
 L08vXmdR70d6MJSmt6pKs7yTjxraF0ZS6gz+F2BTy080jxceZwEWIIbK7zU3tm1hnr7QIbj/
 H6W2Pv9p5CXzQCIw17FXFXjpGPa9knzd4WMzJv2Rgx/m8/ZG91aKq+4Cbz9TLQ7OyRdXqhPJ
 CopfKgZ2l/Fc5+AGhogJLxOopBoELIdHgB50Durx4YJLmQ1z/oimD0O/mUb5fJu0FUQ5Boc1
 kHHJ8J8bZTuFrGAomfvnsek+dyenegqBpZCDniCSfdgeAx9oWNoXG4cgo8OVG7J/1YIWBHRa
 Wnk+WyXGBfbY/8247Gy8oaXtQs1OnehbMKBHRIY0tgoyUlag3wXuUzeK+0PKtWC7ZYelKNC0
 Fn+zL9XpnK3HLE5ckhBLgK8AEQEAAYkCHwQYAQIACQUCU/XOBQIbDAAKCRDZFAuyVhMC8Yyu
 D/9g6+JZZ+oEy7HoGZ0Bawnlxu/xQrzaK/ltQhA2vtiMaxCN46gOvEF/x+IvFscAucm3q4Dy
 bJJkW2qY30ISK9MDELnudPmHRqCxTj8koabvcI1cP8Z0Fw1reMNZVgWgVZJkwHuPYnkhY15u
 3vHDzcWnfnvmguKgYoJxkqqdp/acb0x/qpQgufrWGeYv2yb1YNidXBHTJSuelFcGp/oBXeJz
 rQ2IP1JBbQmQfPSePZzWdSLlrR+3jcBJEP/A/73lSObOQpiYJomXPcla6dH+iyV0IiiZdYgU
 Htwru4Stv/cFVFsUJk1fIOP1qjSa+L6Y0dWX6JMniqUXHhaXo6OPf7ArpVbBygMuzvy99LtS
 FSkMcYXn359sXOYsRy4V+Yr7Bs0lzdnHnKdpVqHiDvNgrrLoPNrKTiYwTmzTVbb9u/BjUGhC
 YUS705vcjBgXhdXS44kgO22kaB5c6Obg7WP7cucFomITovtZs5Rm1iaZZc31lzobfFPUwDSc
 YXOj6ckS9bF9lDG26z3C/muyiifZeiQvvG1ygexrHtnKYTNxqisOGjjcXzDzpS8egIOtIEI/
 arzlqK5RprMLVOl6n/npxEWmInjBetsBsaX/9kJNZFM4Yais5scOnP+tuTnFTW2K9xKySyuD
 q/iLORJYRYMloJPaDAftiYfjFa8zuw1XnQyG17kCDQRT9gX3ARAAsL2UwyvSLQuMxOW2GRLv
 CiZuxtIEoUuhaBWdC/Yq3c6rWpTu692lhLd4bRpKJkE4nE3saaTVxIHFF3tt3IHSa3Qf831S
 lW39EkcFxr7DbO17kRThOyU1k7KDhUQqhRaUoT1NznrykvpTlNszhYNjA0CMYWH249MJXgck
 iKOezSHbQ2bZWtFG3uTloWSKloFsjsmRsb7Vn2FlyeP+00PVC6j7CRqczxpkyYoHuqIS0w1z
 Aq8HP5DDSH7+arijtPuJhVv9uaiD6YFLgSIQy4ZCZuMcdzKJz2j6KCw2kUXLehk4BU326O0G
 r9+AojZT8J3qvZYBpvCmIhGliKhZ7pYDKZWVseRw7rJS5UFnst5OBukBIjOaSVdp6JMpe99o
 caLjyow2By6DCEYgLCrquzuUxMQ8plEMfPD1yXBo00bLPatkuxIibM0G4IstKL5hSAKiaFCc
 2f73ppp7eby3ZceyF4uCIxN3ABjW9ZCEAcEwC40S3rnh2wZhscBFZ+7sO7+Fgsd0w67zjpt+
 YHFNv/chRJiPnDGGRt0jPWryaasDnQtAAf59LY3qd4GVHu8RA1G0Rz4hVw27yssHGycc4+/Z
 ZX7sPpgNKlpsToMaB5NWgc389HdqOG80Ia+sGkNj9ylp74MPbd0t3fzQnKXzBSHOCNuS67sc
 lUAw7HB+wa3BqgsAEQEAAYkEPgQYAQIACQUCU/YF9wIbAgIpCRDZFAuyVhMC8cFdIAQZAQIA
 BgUCU/YF9wAKCRC0OWJbLPHTQ14xD/9crEKZOwhIWX32UXvB/nWbhEx6+PQG2uWsnah7oc5D
 7V+aY7M1jy5af8yhlhVdaxL5xUoepfOP08lkCEuSdrYbS5wBcQj4NE1QUoeAjJKbq4JwxUkX
 Baq2Lu91UZpdKxEVFfSkEzmeMaVvClGjGOtNCUKl8lwLuthU7dGTW74mJaW5jjlXldgzfzFd
 BkS3fsXfcmeDhHh5TpA4e3MYVBIJrq6Repv151g/zxdA02gjJgGvJlXTb6OgEZGNFr8LGJDh
 LP7MSksBw6IxCAJSicMESu5kXsJfcODlm4zFaV8QDBevI/s/TgOQ9KQ/EJQsG+XBAuh0dqpu
 ImmCdhlHx+YaGmwKO1/yhfWvg1h1xbVn98izeotmq1+0J1jt9tgM17MGvgHjmvqlaY+oUXfj
 OkHkcCGOvao5uAsddQhZcSLmLhrSot8WJI0z3NIM30yiNx/r6OMu47lzTobdYCU8/8m7Rhsq
 fyW68D+XR098NIlU2oYy1zUetw59WJLf2j5u6D6a9p10doY5lYUEeTjy9Ejs/cL+tQbGwgWh
 WwKVal1lAtZVaru0GMbSQQ2BycZsZ+H+sbVwpDNEOxQaQPMmEzwgv2Sk2hvR3dTnhUoUaVoR
 hQE3/+fVRbWHEEroh/+vXV6n4Ps5bDd+75NCQ/lfPZNzGxgxqbd/rd2wStVZpQXkhofMD/4k
 Z8IivHZYaTA+udUk3iRm0l0qnuX2M5eUbyHW0sZVPnL7Oa4OKXoOir1EWwzzq0GNZjHCh6Cz
 vLOb1+pllnMkBky0G/+txtgvj5T/366ErUF+lQfgNtENKY6In8tw06hPJbu1sUTQIs50Jg9h
 RNkDSIQ544ack0fzOusSPM+vo6OkvIHt8tV0fTO1muclwCX/5jb7zQIDgGiUIgS8y0M4hIkP
 KvdmgurPywi74nEoQQrKF6LpPYYHsDteWR/k2m2BOj0ciZDIIxVR09Y9moQIjBLJKN0J21XJ
 eAgam4uLV2p1kRDdw/ST5uMCqD4Qi5zrZyWilCci6jF1TR2VEt906E2+AZ3BEheRyn8yb2KO
 +cJD3kB4RzOyBC/Cq/CGAujfDkRiy1ypFF3TkZdya0NnMgka9LXwBV29sAw9vvrxHxGa+tO+
 RpgKRywr4Al7QGiw7tRPbxkcatkxg67OcRyntfT0lbKlSTEQUxM06qvwFN7nobc9YiJJTeLu
 gfa4fCqhQCyquWVVoVP+MnLqkzu1F6lSB6dGIpiW0s3LwyE/WbCAVBraPoENlt69jI0WTXvH
 4v71zEffYaGWqtrSize20x9xZf5c/Aukpx0UmsqheKeoSprKyRD/Wj/LgsuTE2Uod85U36Xk
 eFYetwQY1h3lok2Zb/3uFhWr0NqmT14EL7kCDQRT9gkSARAApxtQ4zUMC512kZ+gCiySFcIF
 /mAf7+l45689Tn7LI1xmPQrAYJDoqQVXcyh3utgtvBvDLmpQ+1BfEONDWc8KRP6Abo35YqBx
 3udAkLZgr/RmEg3+Tiof+e1PJ2zRh5zmdei5MT8biE2zVd9DYSJHZ8ltEWIALC9lAsv9oa+2
 L6naC+KFF3i0m5mxklgFoSthswUnonqvclsjYaiVPoSldDrreCPzmRCUd8znf//Z4BxtlTw3
 SulF8weKLJ+Hlpw8lwb3sUl6yPS6pL6UV45gyWMe677bVUtxLYOu+kiv2B/+nrNRDs7B35y/
 J4t8dtK0S3M/7xtinPiYRmsnJdk+sdAe8TgGkEaooF57k1aczcJlUTBQvlYAEg2NJnqaKg3S
 CJ4fEuT8rLjzuZmLkoHNumhH/mEbyKca82HvANu5C9clyQusJdU+MNRQLRmOAd/wxGLJ0xmA
 ye7Ozja86AIzbEmuNhNH9xNjwbwSJNZefV2SoZUv0+V9EfEVxTzraBNUZifqv6hernMQXGxs
 +lBjnyl624U8nnQWnA8PwJ2hI3DeQou1HypLFPeY9DfWv4xYdkyeOtGpueeBlqhtMoZ0kDw2
 C3vzj77nWwBgpgn1Vpf4hG/sW/CRR6tuIQWWTvUM3ACa1pgEsBvIEBiVvPxyAtL+L+Lh1Sni
 7w3HBk1EJvUAEQEAAYkCHwQYAQIACQUCU/YJEgIbDAAKCRDZFAuyVhMC8QndEACuN16mvivn
 WwLDdypvco5PF8w9yrfZDKW4ggf9TFVB9skzMNCuQc+tc+QM+ni2c4kKIdz2jmcg6QytgqVu
 m6V1OsNmpjADaQkVp5jL0tmg6/KA9Tvr07Kuv+Uo4tSrS/4djDjJnXHEp/tB+Fw7CArNtUtL
 lc8SuADCmMD+kBOVWktZyzkBkDfBXlTWl46T/8291lEspDWe5YW1ZAH/HdCR1rQNZWjNCpB2
 Cic58CYMD1rSonCnbfUeyZYNNhNHZosl4dl7f+am87Q2x3pK0DLSoJRxWb7vZB0uo9CzCSm3
 I++aYozF25xQoT+7zCx2cQi33jwvnJAK1o4VlNx36RfrxzBqc1uZGzJBCQu48UjmUSsTwWC3
 HpE/D9sM+xACs803lFUIZC5H62G059cCPAXKgsFpNMKmBAWweBkVJAisoQeX50OP+/11ArV0
 cv+fOTfJj0/KwFXJaaYh3LUQNILLBNxkSrhCLl8dUg53IbHx4NfIAgqxLWGfXM8DY1aFdU79
 pac005PuhxCWkKTJz3gCmznnoat4GCnL5gy/m0Qk45l4PFqwWXVLo9AQg2Kp3mlIFZ6fsEKI
 AN5hxlbNvNb9V2Zo5bFZjPWPFTxOteM0omUAS+QopwU0yPLLGJVf2iCmItHcUXI+r2JwH1CJ
 jrHWeQEI2ucSKsNa8FllDmG/fQ==
Message-ID: <ef0a4fb1-2c6b-65de-f1ed-71259f47491a@gmail.com>
Date:   Wed, 20 Feb 2019 15:31:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <1550666030-30211-2-git-send-email-qii.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2019 13:33, Qii Wang wrote:
> New i2c registers would have different offsets, so we use different
> offsets array to distinguish different i2c registers version.
> 
> Signed-off-by: Qii Wang <qii.wang@mediatek.com>

Looks good to me :)

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>  drivers/i2c/busses/i2c-mt65xx.c |  163 +++++++++++++++++++++++++--------------
>  1 file changed, 104 insertions(+), 59 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
> index 660de1e..428ac99 100644
> --- a/drivers/i2c/busses/i2c-mt65xx.c
> +++ b/drivers/i2c/busses/i2c-mt65xx.c
> @@ -106,34 +106,62 @@ enum mtk_trans_op {
>  };
>  
>  enum I2C_REGS_OFFSET {
> -	OFFSET_DATA_PORT = 0x0,
> -	OFFSET_SLAVE_ADDR = 0x04,
> -	OFFSET_INTR_MASK = 0x08,
> -	OFFSET_INTR_STAT = 0x0c,
> -	OFFSET_CONTROL = 0x10,
> -	OFFSET_TRANSFER_LEN = 0x14,
> -	OFFSET_TRANSAC_LEN = 0x18,
> -	OFFSET_DELAY_LEN = 0x1c,
> -	OFFSET_TIMING = 0x20,
> -	OFFSET_START = 0x24,
> -	OFFSET_EXT_CONF = 0x28,
> -	OFFSET_FIFO_STAT = 0x30,
> -	OFFSET_FIFO_THRESH = 0x34,
> -	OFFSET_FIFO_ADDR_CLR = 0x38,
> -	OFFSET_IO_CONFIG = 0x40,
> -	OFFSET_RSV_DEBUG = 0x44,
> -	OFFSET_HS = 0x48,
> -	OFFSET_SOFTRESET = 0x50,
> -	OFFSET_DCM_EN = 0x54,
> -	OFFSET_PATH_DIR = 0x60,
> -	OFFSET_DEBUGSTAT = 0x64,
> -	OFFSET_DEBUGCTRL = 0x68,
> -	OFFSET_TRANSFER_LEN_AUX = 0x6c,
> -	OFFSET_CLOCK_DIV = 0x70,
> +	OFFSET_DATA_PORT,
> +	OFFSET_SLAVE_ADDR,
> +	OFFSET_INTR_MASK,
> +	OFFSET_INTR_STAT,
> +	OFFSET_CONTROL,
> +	OFFSET_TRANSFER_LEN,
> +	OFFSET_TRANSAC_LEN,
> +	OFFSET_DELAY_LEN,
> +	OFFSET_TIMING,
> +	OFFSET_START,
> +	OFFSET_EXT_CONF,
> +	OFFSET_FIFO_STAT,
> +	OFFSET_FIFO_THRESH,
> +	OFFSET_FIFO_ADDR_CLR,
> +	OFFSET_IO_CONFIG,
> +	OFFSET_RSV_DEBUG,
> +	OFFSET_HS,
> +	OFFSET_SOFTRESET,
> +	OFFSET_DCM_EN,
> +	OFFSET_PATH_DIR,
> +	OFFSET_DEBUGSTAT,
> +	OFFSET_DEBUGCTRL,
> +	OFFSET_TRANSFER_LEN_AUX,
> +	OFFSET_CLOCK_DIV,
> +};
> +
> +static const u16 mt_i2c_regs_v1[] = {
> +	[OFFSET_DATA_PORT] = 0x0,
> +	[OFFSET_SLAVE_ADDR] = 0x4,
> +	[OFFSET_INTR_MASK] = 0x8,
> +	[OFFSET_INTR_STAT] = 0xc,
> +	[OFFSET_CONTROL] = 0x10,
> +	[OFFSET_TRANSFER_LEN] = 0x14,
> +	[OFFSET_TRANSAC_LEN] = 0x18,
> +	[OFFSET_DELAY_LEN] = 0x1c,
> +	[OFFSET_TIMING] = 0x20,
> +	[OFFSET_START] = 0x24,
> +	[OFFSET_EXT_CONF] = 0x28,
> +	[OFFSET_FIFO_STAT] = 0x30,
> +	[OFFSET_FIFO_THRESH] = 0x34,
> +	[OFFSET_FIFO_ADDR_CLR] = 0x38,
> +	[OFFSET_IO_CONFIG] = 0x40,
> +	[OFFSET_RSV_DEBUG] = 0x44,
> +	[OFFSET_HS] = 0x48,
> +	[OFFSET_SOFTRESET] = 0x50,
> +	[OFFSET_DCM_EN] = 0x54,
> +	[OFFSET_PATH_DIR] = 0x60,
> +	[OFFSET_DEBUGSTAT] = 0x64,
> +	[OFFSET_DEBUGCTRL] = 0x68,
> +	[OFFSET_TRANSFER_LEN_AUX] = 0x6c,
> +	[OFFSET_CLOCK_DIV] = 0x70,
>  };
>  
>  struct mtk_i2c_compatible {
>  	const struct i2c_adapter_quirks *quirks;
> +	const u16 *regs;
>  	unsigned char pmic_i2c: 1;
>  	unsigned char dcm: 1;
>  	unsigned char auto_restart: 1;
> @@ -181,6 +209,7 @@ struct mtk_i2c {
>  };
>  
>  static const struct mtk_i2c_compatible mt2712_compat = {
> +	.regs = mt_i2c_regs_v1,
>  	.pmic_i2c = 0,
>  	.dcm = 1,
>  	.auto_restart = 1,
> @@ -191,6 +220,7 @@ struct mtk_i2c {
>  
>  static const struct mtk_i2c_compatible mt6577_compat = {
>  	.quirks = &mt6577_i2c_quirks,
> +	.regs = mt_i2c_regs_v1,
>  	.pmic_i2c = 0,
>  	.dcm = 1,
>  	.auto_restart = 0,
> @@ -201,6 +231,7 @@ struct mtk_i2c {
>  
>  static const struct mtk_i2c_compatible mt6589_compat = {
>  	.quirks = &mt6577_i2c_quirks,
> +	.regs = mt_i2c_regs_v1,
>  	.pmic_i2c = 1,
>  	.dcm = 0,
>  	.auto_restart = 0,
> @@ -211,6 +242,7 @@ struct mtk_i2c {
>  
>  static const struct mtk_i2c_compatible mt7622_compat = {
>  	.quirks = &mt7622_i2c_quirks,
> +	.regs = mt_i2c_regs_v1,
>  	.pmic_i2c = 0,
>  	.dcm = 1,
>  	.auto_restart = 1,
> @@ -220,6 +252,7 @@ struct mtk_i2c {
>  };
>  
>  static const struct mtk_i2c_compatible mt8173_compat = {
> +	.regs = mt_i2c_regs_v1,
>  	.pmic_i2c = 0,
>  	.dcm = 1,
>  	.auto_restart = 1,
> @@ -238,6 +271,17 @@ struct mtk_i2c {
>  };
>  MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
>  
> +static u16 mtk_i2c_readw(struct mtk_i2c *i2c, enum I2C_REGS_OFFSET reg)
> +{
> +	return readw(i2c->base + i2c->dev_comp->regs[reg]);
> +}
> +
> +static void mtk_i2c_writew(struct mtk_i2c *i2c, u16 val,
> +			   enum I2C_REGS_OFFSET reg)
> +{
> +	writew(val, i2c->base + i2c->dev_comp->regs[reg]);
> +}
> +
>  static int mtk_i2c_clock_enable(struct mtk_i2c *i2c)
>  {
>  	int ret;
> @@ -278,31 +322,31 @@ static void mtk_i2c_init_hw(struct mtk_i2c *i2c)
>  {
>  	u16 control_reg;
>  
> -	writew(I2C_SOFT_RST, i2c->base + OFFSET_SOFTRESET);
> +	mtk_i2c_writew(i2c, I2C_SOFT_RST, OFFSET_SOFTRESET);
>  
>  	/* Set ioconfig */
>  	if (i2c->use_push_pull)
> -		writew(I2C_IO_CONFIG_PUSH_PULL, i2c->base + OFFSET_IO_CONFIG);
> +		mtk_i2c_writew(i2c, I2C_IO_CONFIG_PUSH_PULL, OFFSET_IO_CONFIG);
>  	else
> -		writew(I2C_IO_CONFIG_OPEN_DRAIN, i2c->base + OFFSET_IO_CONFIG);
> +		mtk_i2c_writew(i2c, I2C_IO_CONFIG_OPEN_DRAIN, OFFSET_IO_CONFIG);
>  
>  	if (i2c->dev_comp->dcm)
> -		writew(I2C_DCM_DISABLE, i2c->base + OFFSET_DCM_EN);
> +		mtk_i2c_writew(i2c, I2C_DCM_DISABLE, OFFSET_DCM_EN);
>  
>  	if (i2c->dev_comp->timing_adjust)
> -		writew(I2C_DEFAULT_CLK_DIV - 1, i2c->base + OFFSET_CLOCK_DIV);
> +		mtk_i2c_writew(i2c, I2C_DEFAULT_CLK_DIV - 1, OFFSET_CLOCK_DIV);
>  
> -	writew(i2c->timing_reg, i2c->base + OFFSET_TIMING);
> -	writew(i2c->high_speed_reg, i2c->base + OFFSET_HS);
> +	mtk_i2c_writew(i2c, i2c->timing_reg, OFFSET_TIMING);
> +	mtk_i2c_writew(i2c, i2c->high_speed_reg, OFFSET_HS);
>  
>  	/* If use i2c pin from PMIC mt6397 side, need set PATH_DIR first */
>  	if (i2c->have_pmic)
> -		writew(I2C_CONTROL_WRAPPER, i2c->base + OFFSET_PATH_DIR);
> +		mtk_i2c_writew(i2c, I2C_CONTROL_WRAPPER, OFFSET_PATH_DIR);
>  
>  	control_reg = I2C_CONTROL_ACKERR_DET_EN |
>  		      I2C_CONTROL_CLK_EXT_EN | I2C_CONTROL_DMA_EN;
> -	writew(control_reg, i2c->base + OFFSET_CONTROL);
> -	writew(I2C_DELAY_LEN, i2c->base + OFFSET_DELAY_LEN);
> +	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
> +	mtk_i2c_writew(i2c, I2C_DELAY_LEN, OFFSET_DELAY_LEN);
>  
>  	writel(I2C_DMA_HARD_RST, i2c->pdmabase + OFFSET_RST);
>  	udelay(50);
> @@ -454,7 +498,7 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>  
>  	reinit_completion(&i2c->msg_complete);
>  
> -	control_reg = readw(i2c->base + OFFSET_CONTROL) &
> +	control_reg = mtk_i2c_readw(i2c, OFFSET_CONTROL) &
>  			~(I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS);
>  	if ((i2c->speed_hz > MAX_FS_MODE_SPEED) || (left_num >= 1))
>  		control_reg |= I2C_CONTROL_RS;
> @@ -462,40 +506,41 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>  	if (i2c->op == I2C_MASTER_WRRD)
>  		control_reg |= I2C_CONTROL_DIR_CHANGE | I2C_CONTROL_RS;
>  
> -	writew(control_reg, i2c->base + OFFSET_CONTROL);
> +	mtk_i2c_writew(i2c, control_reg, OFFSET_CONTROL);
>  
>  	/* set start condition */
>  	if (i2c->speed_hz <= I2C_DEFAULT_SPEED)
> -		writew(I2C_ST_START_CON, i2c->base + OFFSET_EXT_CONF);
> +		mtk_i2c_writew(i2c, I2C_ST_START_CON, OFFSET_EXT_CONF);
>  	else
> -		writew(I2C_FS_START_CON, i2c->base + OFFSET_EXT_CONF);
> +		mtk_i2c_writew(i2c, I2C_FS_START_CON, OFFSET_EXT_CONF);
>  
>  	addr_reg = i2c_8bit_addr_from_msg(msgs);
> -	writew(addr_reg, i2c->base + OFFSET_SLAVE_ADDR);
> +	mtk_i2c_writew(i2c, addr_reg, OFFSET_SLAVE_ADDR);
>  
>  	/* Clear interrupt status */
> -	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_STAT);
> -	writew(I2C_FIFO_ADDR_CLR, i2c->base + OFFSET_FIFO_ADDR_CLR);
> +	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +	       I2C_TRANSAC_COMP, OFFSET_INTR_STAT);
> +
> +	mtk_i2c_writew(i2c, I2C_FIFO_ADDR_CLR, OFFSET_FIFO_ADDR_CLR);
>  
>  	/* Enable interrupt */
> -	writew(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP, i2c->base + OFFSET_INTR_MASK);
> +	mtk_i2c_writew(i2c, restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +	       I2C_TRANSAC_COMP, OFFSET_INTR_MASK);
>  
>  	/* Set transfer and transaction len */
>  	if (i2c->op == I2C_MASTER_WRRD) {
>  		if (i2c->dev_comp->aux_len_reg) {
> -			writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
> -			writew((msgs + 1)->len, i2c->base +
> -			       OFFSET_TRANSFER_LEN_AUX);
> +			mtk_i2c_writew(i2c, msgs->len, OFFSET_TRANSFER_LEN);
> +			mtk_i2c_writew(i2c, (msgs + 1)->len,
> +					    OFFSET_TRANSFER_LEN_AUX);
>  		} else {
> -			writew(msgs->len | ((msgs + 1)->len) << 8,
> -			       i2c->base + OFFSET_TRANSFER_LEN);
> +			mtk_i2c_writew(i2c, msgs->len | ((msgs + 1)->len) << 8,
> +					    OFFSET_TRANSFER_LEN);
>  		}
> -		writew(I2C_WRRD_TRANAC_VALUE, i2c->base + OFFSET_TRANSAC_LEN);
> +		mtk_i2c_writew(i2c, I2C_WRRD_TRANAC_VALUE, OFFSET_TRANSAC_LEN);
>  	} else {
> -		writew(msgs->len, i2c->base + OFFSET_TRANSFER_LEN);
> -		writew(num, i2c->base + OFFSET_TRANSAC_LEN);
> +		mtk_i2c_writew(i2c, msgs->len, OFFSET_TRANSFER_LEN);
> +		mtk_i2c_writew(i2c, num, OFFSET_TRANSAC_LEN);
>  	}
>  
>  	/* Prepare buffer data to start transfer */
> @@ -607,14 +652,14 @@ static int mtk_i2c_do_transfer(struct mtk_i2c *i2c, struct i2c_msg *msgs,
>  		if (left_num >= 1)
>  			start_reg |= I2C_RS_MUL_CNFG;
>  	}
> -	writew(start_reg, i2c->base + OFFSET_START);
> +	mtk_i2c_writew(i2c, start_reg, OFFSET_START);
>  
>  	ret = wait_for_completion_timeout(&i2c->msg_complete,
>  					  i2c->adap.timeout);
>  
>  	/* Clear interrupt mask */
> -	writew(~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> -	       I2C_TRANSAC_COMP), i2c->base + OFFSET_INTR_MASK);
> +	mtk_i2c_writew(i2c, ~(restart_flag | I2C_HS_NACKERR | I2C_ACKERR |
> +	       I2C_TRANSAC_COMP), OFFSET_INTR_MASK);
>  
>  	if (i2c->op == I2C_MASTER_WR) {
>  		dma_unmap_single(i2c->dev, wpaddr,
> @@ -724,8 +769,8 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
>  	if (i2c->auto_restart)
>  		restart_flag = I2C_RS_TRANSFER;
>  
> -	intr_stat = readw(i2c->base + OFFSET_INTR_STAT);
> -	writew(intr_stat, i2c->base + OFFSET_INTR_STAT);
> +	intr_stat = mtk_i2c_readw(i2c, OFFSET_INTR_STAT);
> +	mtk_i2c_writew(i2c, intr_stat, OFFSET_INTR_STAT);
>  
>  	/*
>  	 * when occurs ack error, i2c controller generate two interrupts
> @@ -737,8 +782,8 @@ static irqreturn_t mtk_i2c_irq(int irqno, void *dev_id)
>  	if (i2c->ignore_restart_irq && (i2c->irq_stat & restart_flag)) {
>  		i2c->ignore_restart_irq = false;
>  		i2c->irq_stat = 0;
> -		writew(I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG | I2C_TRANSAC_START,
> -		       i2c->base + OFFSET_START);
> +		mtk_i2c_writew(i2c, I2C_RS_MUL_CNFG | I2C_RS_MUL_TRIG |
> +				    I2C_TRANSAC_START, OFFSET_START);
>  	} else {
>  		if (i2c->irq_stat & (I2C_TRANSAC_COMP | restart_flag))
>  			complete(&i2c->msg_complete);
> 
