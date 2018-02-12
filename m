Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2398327-1518472250-2-12189863037575232653
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
    t=1518472249; b=EsSSYr7g5AuxiJHhOpQ6D0fSQUyINy5VLQwgjcqswIqggK3
    nhpD+ta55/0B97xosPHtvJTxZs/5lzfI1yAg2S/6Ijdzjx0I5Gc3GiZMQrkKvKYg
    YaAvZ0mJ0838LOkR3j/TdV7onjZU5Vr2PUxKMA6/L1l+ZQw2v+YK3fqTo8CDj03O
    m7rIb2g5PsWvRyJyY/pn1hACy+kYTDrbd03vBQc/b9gcY2KI4NTso4VyWqeC0Y7X
    cMSRrzBPDXymkQFZcmdcc6eo3uXLScN0sU71tC81a+rtY1xAFe8DCqq3rvS2unvR
    f3p8WcldmQ73ost6wy1dVVVArrbz/kPRXA2MW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1518472249; bh=DJRig3i+
    oxv6pKjrlrsmqXdtAxRS8WzbDV4MdrnI298=; b=qp6K9HYixcJ0iPqlD3Ek1+10
    Z5uzqPbOcWrLhe8RuPBcnzCAZVnGh3vyggCbf62BfABOhjpLm1sNYwKjbB0QWGIb
    5ifPDLPcKWXvF4/21rIueXrwIsvoIToB3TEegre9FqM/8rph5lfBbrGaB7cD9Sw6
    f5GVAIwIDDd4HFCWxPuIfo/cUM5DnTz6vra/BiPjPLMbPpukZ7jpj5ophlehOuvJ
    e4gM6xpL+CPR/r1n+xH0N7afwKjQU+7oxK3Y/UaTH6sd2GARqbQt5xD6vMcWxsbw
    yhHPyiN6fBMiHOg0u4lY9Pqrl44ZHgZIESDKYE3qzDyINcf5hbaMppvlevTMJQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=HTFzAJlp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=HTFzAJlp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932231AbeBLVuq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Feb 2018 16:50:46 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:63131 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeBLVup (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Feb 2018 16:50:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180212215043epoutp02534f310bd29c3671bb042cbe1b3f2251~SsnXsttQA1288312883epoutp02g
X-AuditID: b6c32a48-9adff70000000ff0-24-5a820c32d01a
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A820C33.5000209@samsung.com>
Date: Tue, 13 Feb 2018 06:50:43 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/3] extcon: int3496: process id-pin first so that we
 start with the right status
In-reply-to: <20180212194630.7216-3-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIKsWRmVeSWpSXmKPExsWy7bCmha4RT1OUwYslWhZvjk9nsri8aw6b
        xe3GFWwWCzY+YnRg8Xi/7yqbR9+WVYwenzfJBTBHpdpkpCampBYppOYl56dk5qXbKnkHxzvH
        m5oZGOoaWlqYKynkJeam2iq5+AToumXmAG1TUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gq
        RRsaGukZGpjrGRkZ6ZkYx1oZmQKVJKRmXDx7lq1gvkDF8eN7mBsYJ/B2MXJwSAiYSLzcH9vF
        yMUhJLCDUWLetZnMEM53Ron2vq0sXYycYEXvVp5nB7GFBHYzSuy6zwRi8woISvyYfI8FZBCz
        gLzEkUvZIGFmAU2JrbvXs0PMuccoceNtJytEvZbEkpmrGEFsFgFViW3Pu8HibEDx/S9usIHY
        /AKKEld/PAarERWIkNg5/xvYXhGBIIkb31ewQuyykGjfbwoSFhbIkri0ZBbYOZxA4QcXGlhB
        9koILGGTODn9MCvE/S4SHw48hPpFWOLV8S3sELa0xLNVGxkhGtqBHt47jxnCmcIoce76PSaI
        KmOJZwu7mCBe45PoOPyXHRJ0vBIdbUIQJR4Sa3a3Qy1zlNj/ZyoTxPc7GSUOfVvMNoFRbhZS
        gM1CBNgspABbwMi8ilEstaA4Nz212KjARK84Mbe4NC9dLzk/dxMjOHlpeexgPHDO5xCjAAej
        Eg9vx+zGKCHWxLLiytxDjBIczEoivH+agUK8KYmVValF+fFFpTmpxYcYTYHhPZFZSjQ5H5hY
        80riDU0sDUzMzIzMzSyA6Uucty3AJUpIID2xJDU7NbUgtQimj4mDU6qBsfX4gTkOCtNFHL/M
        bTa/X1n7ROydsN9hvc79h7xv2vY/iZi2wPzdB6l1y2fcyZ5+x/BL/6dIe7Y/5W9qQ9yzTh9W
        71jmvF2JjWWliXFxoprmxGrJb+cCG8017W+Jmus/WcLRm+JXJXSd9VJMjbnHLfulkZmi1u+f
        PvXN4fGwuXKEfbffsyvrlViKMxINtZiLihMBxa4isHQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCLMWRmVeSWpSXmKPExsVy+t9jAV1DnqYog7MdahZvjk9nsri8aw6b
        xe3GFWwWCzY+YnRg8Xi/7yqbR9+WVYwenzfJBTBHcdmkpOZklqUW6dslcGVcPHuWrWC+QMXx
        43uYGxgn8HYxcnJICJhIvFt5nr2LkYtDSGAno8TyPadZQRK8AoISPybfY+li5OBgFpCXOHIp
        GyTMLKAuMWneImaI+geMEu/u3GGEqNeSWDJzFZjNIqAqse15N9gcNqD4/hc32EBsfgFFias/
        HjOCzBQViJDoPlEJEhYRCJD4eaqfHWKVhUT7flOQsLBAlsSlJbOY4E57O+USM0iCE6jmwYUG
        1gmMArOQXDoL4dJZSC5dwMi8ilEytaA4Nz232KjAKC+1XK84Mbe4NC9dLzk/dxMjMGy3Hdbq
        38H4eEn8IUYBDkYlHt6O2Y1RQqyJZcWVuYcYJTiYlUR4/zQDhXhTEiurUovy44tKc1KLDzFK
        c7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTC6qEkl3KtZaZx69cWxjbPF7/3bfq0lWYar
        acrGfUWZi0ONPwkrTv6yLW+3wgPD3ZWfkn2y75/f1aRZ5qxsNfXwT+GSCYpfXVoY61fOYvL4
        NcPrwfYaJ6ZiOc4z54qlL8526mC+Em+4kM/tzRv/G/zql2Oq7SIEsq4vO9B78fC797W2saaW
        Ny4qsRRnJBpqMRcVJwIA9sYdulcCAAA=
X-CMS-MailID: 20180212215041epcas2p25bf787274bd464ce2c3444af8ced2ed2
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180212194708epcas2p325a2042527bfd037d4e56a0d4812c37a
X-RootMTR: 20180212194708epcas2p325a2042527bfd037d4e56a0d4812c37a
References: <20180212194630.7216-1-hdegoede@redhat.com>
        <CGME20180212194708epcas2p325a2042527bfd037d4e56a0d4812c37a@epcas2p3.samsung.com>
        <20180212194630.7216-3-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 02월 13일 04:46, Hans de Goede wrote:
> Some other drivers may be waiting for our extcon to show-up (exiting their
> probe methods with -EPROBE_DEFER until we show up).
> 
> These drivers will typically get the cable state directly after getting
> the extcon, this commit changes the int3496 code to process the id-pin
> before registering the extcon, so that other drivers see the correct state
> right away.
> 
> Fixes: 2f556bdb9f2e ("extcon: int3496: Add Intel INT3496 ACPI ... driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> -Add Fixes tag
> 
> Changes in v3:
> -Fix oops on probe by scheduling the work too early
> ---
>  drivers/extcon/extcon-intel-int3496.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index c8691b5a9cb0..673bb26a9a2a 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -131,11 +131,15 @@ static int int3496_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->gpio_usb_mux))
>  		dev_info(dev, "can't request USB MUX GPIO\n");
>  
> -	/* register extcon device */
>  	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
>  	if (IS_ERR(data->edev))
>  		return -ENOMEM;
>  
> +	/* process id-pin first so that we start with the right status */
> +	queue_delayed_work(system_wq, &data->work, 0);
> +	flush_delayed_work(&data->work);
> +
> +	/* register extcon device */
>  	ret = devm_extcon_dev_register(dev, data->edev);
>  	if (ret < 0) {
>  		dev_err(dev, "can't register extcon device: %d\n", ret);
> @@ -153,9 +157,6 @@ static int int3496_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/* queue initial processing of id-pin */
> -	queue_delayed_work(system_wq, &data->work, 0);
> -
>  	platform_set_drvdata(pdev, data);
>  
>  	return 0;
> 

Applied it.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
