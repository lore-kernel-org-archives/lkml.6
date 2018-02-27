Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2668365-1519771579-2-8943101247727080135
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519771578; b=ljyW6Xtz/I5ARNPd+sW+Iwxz/oIWef6G4eC5XonXlq8Al3y
    hZc5TD2ihUgIOHzzwsDD0te05fkAfNkKhq+XNibJ076IDKSYrZvKyU1ldKTne6cS
    F8r74Yd4xyZmF/NMvUcds4rikR8wbVZLgRB/DHayQ3nS180E0ehUXMZTuUgXZ9L1
    s9sUcTyAprwPnQb6UZ2KaFPPzBW8fGGvjYH7XAWngm4UYVNiaYlUPBVr7K2tpatY
    SWLShJ0mGo3kYMcxl6wYZapS1Kp7dWb3H9wphDD/QhgQ4m3rRmfT3Hv9zIR2AgDY
    Ws32VB3dIyTalswC5ZrdwV1ARc382BBl9kjkQiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:from:message-id:date
    :mime-version:in-reply-to:content-type:content-transfer-encoding
    :references:sender:list-id; s=arctest; t=1519771578; bh=46SxluIo
    wIoNWH/YWYLzN2uUvT1oqOv4oM1yZMmYNu0=; b=haIpE8OWMkggB8vGhICga92x
    Olq6dWe/aVn+Gp28mgdTyd5/fnOFLphcAraQYzMT/WO+ZuS+YSErXHS1VYsvmqpv
    harxwEvr3awJPt+SuR47fn7SjY5tB3/wZAQJJwStF+VAX4HxhTRkEiIcesOTe4ux
    pxBxihOwcqkwbNz6k3Upl4uZ4DcRyRbU2660w82KLo0APctESPqCizAv3Cvvr0dY
    twZ0UrlHJlN5m29dcjE6YCJ6pTBPnmZbEByfSobiF9HdgTXYuoi7TaEiNeitdeDM
    afHKCve+fywoRj1kyT/J/RQeOCM6HEbFu7hBGHhaOKcObA0CyY66W3B1CKmGuA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=RH/vCd8x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=RH/vCd8x x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752047AbeB0WqF (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 17:46:05 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:61749 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeB0WqD (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 27 Feb 2018 17:46:03 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180227224602epoutp0174302c78af4f68e8d9745db7507ea6ff~XUC8CGEEk2553625536epoutp01b
X-AuditID: b6c32a38-adbff70000001054-f6-5a95dfa92a34
Subject: Re: [PATCH] usbip: tools usbip_attach: Fix cryptic error messages
To: Shuah Khan <shuahkh@osg.samsung.com>, valentina.manea.m@gmail.com,
        shuah@kernel.org, gregkh@linuxfoundation.org
Cc: yuyang.du@intel.com, nobuo.iwata@fujixerox.co.jp,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From: Krzysztof Opasiak <k.opasiak@samsung.com>
Message-id: <8b7b3f6a-4075-e7e3-39ac-51ddb8f961a0@samsung.com>
Date: Tue, 27 Feb 2018 23:45:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
        Thunderbird/52.6.0
MIME-version: 1.0
In-reply-to: <20180227222356.23245-1-shuahkh@osg.samsung.com>
Content-type: text/plain; charset="utf-8"; format="flowed"
Content-language: en-US
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsWy7bCmru7K+1OjDI6/MLdoXryezeLyrjls
        FouWtTJb3Oq4ymIx5eU6doupXz6wWLy7NJfd4vmq5YwOHB4f1x9l9tg56y67x+I9L5k8Nq3q
        ZPPYP3cNu8eWfqDY501yAexRXDYpqTmZZalF+nYJXBm//lxiK9jHWTHnwHn2Bsaz7F2MnBwS
        AiYSqzpOsnQxcnEICexglJjY9p0VwvnOKHGwdQYLTNW9nU9YQWwhgQ2MEk+aYiHs+4wS7/tt
        QGxhAS+JWS9+s4HYIgKlEge/7gHrZRbIl5i3Yw3QNg4ONgF9iXm7REHCvAJ2Ei+7joGNZBFQ
        lVj36i9Yq6hAhMTCqU8ZIWoEJX5Mvgc2hlPAVuLKwz+sECOtJJ79a4WyxSWaW29CrZKX2Lzm
        LTPI/RIC99kkOo8vgPrSRWL7r+VsELawxKvjW8DukRCQlrh01Baifh2jxOQL+1khnN2MEvv6
        HjFDNFhL/Fk1kQ1iA5/Eu689rBDNvBIdbUIQJR4S045+gIaVo8SLGT1skECcwChx90E/6wRG
        uVlIHpqF5IlZSJ6YheSJBYwsqxjFUguKc9NTiw0LTPSKE3OLS/PS9ZLzczcxghOOlsUOxj3n
        fA4xCnAwKvHwZmRPjRJiTSwrrsw9xCjBwawkwlt9GyjEm5JYWZValB9fVJqTWnyIUZqDRUmc
        NyDAJUpIID2xJDU7NbUgtQgmy8TBKdXAmHvpguzxTL0jawtfpn38vuXG8zwGT4bKgphj7Y+V
        9q/4Od/N4JNC65bZbmlVby7misau//U87t0zjfqn81Uv/yt/Yrs36vefOdyM35WyJFYkK79c
        8p7tzx6miN+LhWwnL1SR330/OVOEX9Mz1Xqnxq7ksyueVG3OnrvqWsf82uTyFzpiXe+CFJVY
        ijMSDbWYi4oTAXpGpk00AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsVy+t9jQd2V96dGGcycqWnRvHg9m8XlXXPY
        LBYta2W2uNVxlcViyst17BZTv3xgsXh3aS67xfNVyxkdODw+rj/K7LFz1l12j8V7XjJ5bFrV
        yeaxf+4ado8t/UCxz5vkAtijuGxSUnMyy1KL9O0SuDJ+/bnEVrCPs2LOgfPsDYxn2bsYOTkk
        BEwk7u18wtrFyMUhJLCOUeLQ7QdMEM5DRonNZ96wgFQJC3hJzHrxmw3EFhEoleg43MQKYjML
        5EssOHASqmESo0TXvr1AYzk42AT0JebtEgWp4RWwk3jZdQysnkVAVWLdq79gc0QFIiQ6V85n
        gagRlPgx+R6YzSlgK3Hl4R+o+WYSX14ehrLFJZpbb7JA2PISm9e8ZZ7AKDALSfssJC2zkLTM
        QtKygJFlFaNkakFxbnpusVGBYV5quV5xYm5xaV66XnJ+7iZGYJRsO6zVt4Px/pL4Q4wCHIxK
        PLwZ2VOjhFgTy4orcw8xSnAwK4nwVt8GCvGmJFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkgg
        PbEkNTs1tSC1CCbLxMEp1cCY/KjXtty+4NjrLQ5F+5YstCuJynh14dKPLzvtHdaEXLnHkDX1
        cVqAtBNvQPZZrsN2oVbGx5K0kjrmWBxWq+byfpd+6PdnPwkxY+20AH2Gneb3dVtC7O5ar1+s
        JWRk+F2YY9PR291/3ixvzgm3me9km3bBr0Q+PM/ilMjEz8JTdpjP0l18JUeJpTgj0VCLuag4
        EQCDRLswjgIAAA==
X-CMS-MailID: 20180227224601epcas1p2d95ba77c214fd7d0a8c12ba29c595a86
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180227222421epcas2p23e030c5de1620f5976cf4f91a2685682
X-RootMTR: 20180227222421epcas2p23e030c5de1620f5976cf4f91a2685682
References: <CGME20180227222421epcas2p23e030c5de1620f5976cf4f91a2685682@epcas2p2.samsung.com>
        <20180227222356.23245-1-shuahkh@osg.samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 02/27/2018 11:23 PM, Shuah Khan wrote:
> Attach device error message is cryptic and useless. Fix it to be
> informative.
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>   tools/usb/usbip/src/usbip_attach.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/usb/usbip/src/usbip_attach.c b/tools/usb/usbip/src/usbip_attach.c
> index 7f07b2d50f59..f60738735398 100644
> --- a/tools/usb/usbip/src/usbip_attach.c
> +++ b/tools/usb/usbip/src/usbip_attach.c
> @@ -195,7 +195,8 @@ static int attach_device(char *host, char *busid)
>   
>   	rhport = query_import_device(sockfd, busid);
>   	if (rhport < 0) {
> -		err("query");
> +		err("Attach request for Device %s. Is this device exported?",
> +		    busid);
>   		return -1;
>   	}

The code itself is ok and you may put my:

Reviewed-by: Krzysztof Opasiak <k.opasiak@samsung.com>

but just because of my curiosity, there is a number of places in usbip 
tools where the same level of descriptiveness is used for error message. 
Why did you choose to fix this one not any other or all others?;)

Best regards,
-- 
Krzysztof Opasiak
Samsung R&D Institute Poland
Samsung Electronics
