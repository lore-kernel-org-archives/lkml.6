Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3993364-1518392181-2-4683593431187592754
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
    t=1518392180; b=kFEQhci6OqDY74kXMUrrtbwddXnJ8/BFDUMp+s/JIpftkHO
    e7ILyawH815jJl4vdmZeG+IC/FMUjNIdZbOjlzgs9nEOayhNji07/D+bvAf7c9Ki
    DmZ5DZvQI4zFC6h13FFBRHvMkQm7diQRgWuCJS6gmuQ8uJbFBVzGUg9sZ4jyN2Df
    yrb60fYleQrbs9J6CB4s+SghRhAtLsP5EXtCSxsM7f0lO+mCXpEMHrZP2UaMANGf
    TmDU3vKq9sXKWL8YV1Qthc4nTHlwdD15Ck70guZEFqvuZYo9pIO9c6z+Jfucgy2Y
    XQ1MhS21/CkmdJAn/51SQsCPNFTxY9gwFtuHWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1518392180; bh=JnEl6iG5
    DWlVeM4Dr6V0p0/1xRqmxNgijcxsJ4o6tM8=; b=tb9EqjF+oUvfl2CV9ZN4qGMO
    smKZ6hkdhtknKPC62GW670V9DSWJFUdEX5zDvbLBju52WNh27yvb0+65yYgYkFRg
    cEiQ8cotv8gpBl+55ODZ/BbTK/qF6lI0VJbMlgwAENaQGBW84qN90wHqsnz+SmCz
    gvnGZHsDS9rKFpznHLRx1OcM2FRVoA7JgdZoKVZeZKwYXEvuEkdY/GUBqa/+W24k
    g9rhSBq25YrMbXVzwsV4j8KT1KRMBPbBrJhGj0zWPsuybw/d2x++BJtz/8xRF1YW
    Ih/bJvWs2lydhAkGwfgilcoT17fyzYpC8oGhMNnEAJFx8bsEwU1e+HMnZeTnhw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=avT12asD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=avT12asD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeBKXgQ (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Feb 2018 18:36:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:60089 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932193AbeBKXgP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Feb 2018 18:36:15 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180211233613epoutp01dea3062149db3d7f8034ec975c303183~SaaL4ql_A0095200952epoutp01N
X-AuditID: b6c32a48-9adff70000000ff0-97-5a80d36c3274
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5A80D36D.9050206@samsung.com>
Date: Mon, 12 Feb 2018 08:36:13 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] extcon: intel-int3496: Fix oops on probe
In-reply-to: <20180211232633.13565-1-hdegoede@redhat.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEKsWRmVeSWpSXmKPExsWy7bCmmW7O5YYog33T2CzeHJ/OZHF51xw2
        i9uNK9gsFmx8xOjA4vF+31U2j74tqxg9Pm+SC2COSrXJSE1MSS1SSM1Lzk/JzEu3VfIOjneO
        NzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMAdqmpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFV
        ijY0NNIzNDDXMzIy0jMxjrUyMgUqSUjNuPTkL2vBPf6Km7OmszcwvuPpYuTkkBAwkVh1dgFb
        FyMXh5DADkaJH1NXsEI43xklrv08zg5T9XTRaqjEbkaJlSd+sIEkeAUEJX5MvsfSxcjBwSwg
        L3HkUjZImFlAU2Lr7vXsEPX3GCV+nXrEDFGvJTHv4g5mkHoWAVWJS71gYTag8P4XN8BG8gso
        Slz98ZgRxBYViJDYOf8b2A0iAkESN76DHAeyykKifb8pSFhYwFbi2bw/YK2cApYS5xZfZQRZ
        KyGwgk3ixd4JrBD3u0gs2rGSBcIWlnh1fAvUX9ISz1ZthGpoZ5Ro3zuPGcKZwihx7vo9Jogq
        Y4lnC7uYID7jk+g4/Jcd5AoJAV6JjjYhiBIPiZ+PGhghbEeJU7vOQj3fwyix7uoF5gmMcrOQ
        wmsWIrxmIYXXAkbmVYxiqQXFuempxUYFJnrFibnFpXnpesn5uZsYwelLy2MH44FzPocYBTgY
        lXh4HaobooRYE8uKK3MPMUpwMCuJ8HZeAArxpiRWVqUW5ccXleakFh9iNAUG90RmKdHkfGBq
        zSuJNzSxNDAxMzMyN7MAJjBx3rYAlyghgfTEktTs1NSC1CKYPiYOTqkGRj/Tl0v0jmtF9azL
        mrRE0H7hl7CMKG/ejXF7wnlOh+o8zGdRzMqbZfT452JXrocHeRPMnkdNsrjmrbjPQ6DFadbt
        T/y1IWnxDYwFn1emHegRVvnqEXIltnz+xzOJxhtmZ2191d/tstwr81faemf9rzZqG4LDQguv
        sj+fKpn2aePv0y0Vb/wuK7EUZyQaajEXFScCAATYaId1AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsVy+t9jAd3syw1RBneOalu8OT6dyeLyrjls
        FrcbV7BZLNj4iNGBxeP9vqtsHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJVx6clf1oJ7/BU3
        Z01nb2B8x9PFyMkhIWAi8XTRatYuRi4OIYGdjBJLL39mBknwCghK/Jh8j6WLkYODWUBe4sil
        bJAws4C6xKR5i5gh6h8A1bc/YIGo15KYd3EHM0g9i4CqxKVesDFsQOH9L26wgdj8AooSV388
        ZgQpERWIkOg+UQkSFhEIkPh5qp8dYpOFRPt+U5CwsICtxLN5f8A6hQT6GCVet7OC2JwClhLn
        Fl9lnMAoMAvJnbMQ7pyF5M4FjMyrGCVTC4pz03OLjQqM8lLL9YoTc4tL89L1kvNzNzECQ3bb
        Ya3+HYyPl8QfYhTgYFTi4XWobogSYk0sK67MPcQowcGsJMLbeQEoxJuSWFmVWpQfX1Sak1p8
        iFGag0VJnJc//1ikkEB6YklqdmpqQWoRTJaJg1OqgTGu6dqfuJJ5hrcXszdNaqqpu+AlIKM1
        J+FvVZnSvAYmzm9fEu8ebvQX3cBcmbFi3cIGUcauhvcTpeaISX0uffCM6Vy5UQrTnp4Uqf8K
        az76c2+/+3DF9mXMN6w2tcaeWvCOfx3j+8QrDCsf34la8dtYbcH+a8KlvkeyQlgbY+XnL0v4
        +f1D6i4lluKMREMt5qLiRADCvGbNVQIAAA==
X-CMS-MailID: 20180211233611epcas2p1ae335a2b0345f91a0e019f888db4ae98
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180211232639epcas2p4495c006e2063cde1ce86710767cd8e97
X-RootMTR: 20180211232639epcas2p4495c006e2063cde1ce86710767cd8e97
References: <CGME20180211232639epcas2p4495c006e2063cde1ce86710767cd8e97@epcas2p4.samsung.com>
        <20180211232633.13565-1-hdegoede@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 02월 12일 08:26, Hans de Goede wrote:
> Commit 41d600274fbf ("extcon: int3496: process id-pin first so that we
> start with the right status") starts the work on the workqueue before
> registration to make sure we've a valid cable state directly after
> registration.
> 
> But that commit moves the queuing of the work to before we even alloc the
> extcon, causing a NULL pointer deref in the worker.
> 
> This commit moves the queuing of the work to after we alloc the extcon,
> fixing the NULL pointer deref.
> 
> Fixes: 41d600274fbf ("extcon: int3496: process id-pin first ...")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/extcon/extcon-intel-int3496.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/extcon/extcon-intel-int3496.c b/drivers/extcon/extcon-intel-int3496.c
> index b23ee9d993a3..673bb26a9a2a 100644
> --- a/drivers/extcon/extcon-intel-int3496.c
> +++ b/drivers/extcon/extcon-intel-int3496.c
> @@ -131,15 +131,15 @@ static int int3496_probe(struct platform_device *pdev)
>  	if (IS_ERR(data->gpio_usb_mux))
>  		dev_info(dev, "can't request USB MUX GPIO\n");
>  
> +	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
> +	if (IS_ERR(data->edev))
> +		return -ENOMEM;
> +
>  	/* process id-pin first so that we start with the right status */
>  	queue_delayed_work(system_wq, &data->work, 0);
>  	flush_delayed_work(&data->work);
>  
>  	/* register extcon device */
> -	data->edev = devm_extcon_dev_allocate(dev, int3496_cable);
> -	if (IS_ERR(data->edev))
> -		return -ENOMEM;
> -
>  	ret = devm_extcon_dev_register(dev, data->edev);
>  	if (ret < 0) {
>  		dev_err(dev, "can't register extcon device: %d\n", ret);
> 

Instead, You better to send v3 after merging your patch[1] and this patch.
[1] extcon: int3496: process id-pin first so that we start with the right status

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
