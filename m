Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-90693-1519950606-2-9848028473420866867
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
    t=1519950605; b=W72DM4G7PVML9xXPXJ0UuY2jtIsl9zLp1o0wZY+FZEC2xIX
    gBwuY4ouxRxyqeDakTVLHkrUSZoTsKBBk9oBYvCmV/0NWEZD8eN/zLLJky3jnMia
    qonnyoYLrjn+KgbMv28fl60lb4X0b6OYS+qTIm/ypd6axztAPU1vLYquKI3PE5J1
    RIvaHZ2sFqmZjcpg+whCTwrKl4ffmdg4sUkWKOLig6HQQY3IKNJdeBJqLSZ6zNV1
    4eVBMQnJFrkl4oheSD6BEK6xZDT9dUWIBcMCyo7h4TZdpqxZLsD5svid7cmA5qf1
    d79SOLkayBXC8zOFwratVFuZskXH42McpH8QGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:content-transfer-encoding
    :content-type:message-id:date:from:to:cc:subject:in-reply-to
    :references:sender:list-id; s=arctest; t=1519950605; bh=5boohmhr
    mxsH71j8iivYrRPKXKOMbIGsRXXZrnFV1x0=; b=cLp0JIZedPKwtPQtfnZKwcLj
    VKCsNOWhu8gzILsGy3A2mAc41UReVYKS21GjA4ABf2oBru8fWz71w/zumVq/SZ98
    WpQz5+3/Q6fdZNXpnjfrpPF1M2s1pRwPqIA9VtivsCFS5T/ExbFRRMTtaHgVOP7X
    6780Z/rq2eTUyaroqGXLjH3mDb0Gqk+VhmYWJjru6cljLWz/wr6unWMwGgOattUg
    CAfIwnu3F/muFfqa7b+43eS/MwMgNeLpGr5dC6JPg/EaosBaajuoAI6Nvo30gJYf
    BVPi/lttDfoLRFfaIrSNGpmtDvAqUXe7FlXTitbovJWOt3+8MkqdJ3IAamlz4Q==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=XR20Ddt9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=samsung.com header.i=@samsung.com header.b=XR20Ddt9 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=mail20170921;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=samsung.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=samsung.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163346AbeCBA3v (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Mar 2018 19:29:51 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:37314 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163135AbeCBA3s (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 1 Mar 2018 19:29:48 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20180302002945epoutp015f06fb4cd7a9b48397159ab42b51aa09~X8wEtX8KD1079410794epoutp01Z
X-AuditID: b6c32a46-3a9ff70000001029-d2-5a989af8c25b
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="utf-8"
Message-id: <5A989AF7.50704@samsung.com>
Date: Fri, 02 Mar 2018 09:29:43 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
        Thunderbird/31.6.0
To: Andrzej Hajda <a.hajda@samsung.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>
Cc: Maciej Purski <m.purski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Archit Taneja <architt@codeaurora.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 6/6] drm/bridge/sii8620: use micro-USB cable
 detection logic to detect MHL
In-reply-to: <54edf1d7-056f-ad75-4d94-e1efa2ffdc1c@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGJsWRmVeSWpSXmKPExsWy7bCmhe6PWTOiDHoPqFncWneO1aKp4y2r
        xcYZ61kt5h8Bcq98fc9mMen+BBaL8+c3sFt0TlzCbrHp8TVWi8u75rBZzDi/j8li0bJWZosF
        L2+xWKw9cpfdYun1i0wWrXuPsDsIeKyZt4bR43JfL5PH7I6ZrB6bVnWyedzvPs7ksXlJvUff
        llWMHp83yQVwRKXaZKQmpqQWKaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE
        6Lpl5gB9oKRQlphTChQKSCwuVtK3synKLy1JVcjILy6xVYo2NDTSMzQw1zMyMtIzMY61MjIF
        KklIzehp3cJasE+v4tDu86wNjHvUuhg5OSQETCQePnjKCGILCexglLjdwNrFyAVkf2eUWP/9
        FTNM0ekfE9ghErsZJZ4sX8sEkuAVEJT4MfkeSxcjBwezgLzEkUvZIGFmAU2JF18msUDU32OU
        mHNwAQtEvYZE78mjbCA2i4CqxOmPK9hBbDYBLYn9L26AxfkFFCWu/ngMdpGoQITEzvnfwBaL
        CLQwSuxoXgY2lVlgJYvEupnNrCBVwgLJEleXvgbr5hSwl/i36DkjxNnL2CXOruWDsF0kZuw7
        wQZhC0u8Or6FHcKWlni2aiMjyFAJgXZGifa985ghnCmMEueu32OCqDKWeLawiwniOT6JjsN/
        2UF+lhDglehoE4Io8ZA4t+kpVNhR4vyZaEiYPmWSmN0tNoFRbhZSgM1CBNgspABbwMi8ilEs
        taA4Nz212KjASK84Mbe4NC9dLzk/dxMjOM1que1gXHLO5xCjAAejEg/vDs4ZUUKsiWXFlbmH
        GCU4mJVEeE9vnxYlxJuSWFmVWpQfX1Sak1p8iNEUGN4TmaVEk/OBOSCvJN7QxNLAxMzMyNzM
        ApjAxHlbA1yihATSE0tSs1NTC1KLYPqYODilGhgvvZhd+ex+9AbrbhsHXs/4H2vX2hQIhxVt
        Sl6ifO9SRe2c4sTjM3U6Pff0X3r1a27fr/qtJ+2Off9Q8t3ZdlHt5pS/icmtry+H+hp2T+QS
        lHH6lKR07sPXK2cWNamXn6nWUqt4d3nn2T+/psT6S/hd2+7Tmjf/enLJr6qN4v/Upio/C3vI
        PveGEktxRqKhFnNRcSIAy0tCE8kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsVy+t9jAd0fs2ZEGXxcw2xxa905Voumjres
        FhtnrGe1mH8EyL3y9T2bxaT7E1gszp/fwG7ROXEJu8Wmx9dYLS7vmsNmMeP8PiaLRctamS0W
        vLzFYrH2yF12i6XXLzJZtO49wu4g4LFm3hpGj8t9vUwesztmsnpsWtXJ5nG/+ziTx+Yl9R59
        W1YxenzeJBfAEcVlk5Kak1mWWqRvl8CV0dO6hbVgn17Fod3nWRsY96h1MXJySAiYSJz+MYG9
        i5GLQ0hgJ6PEzk132EESvAKCEj8m32PpYuTgYBaQlzhyKRvCVJeYMiUXovwBo0Tjla9Q5RoS
        vSePsoHYLAKqEqc/rgCLswloSex/cQMszi+gKHH1x2NGkDmiAhES3ScqQeaICLQxSmyfsYsR
        pIZZYDWLxNyvKiC2sECyxMuGrYwQy54ySXxecoQVJMEpYC/xb9FzxgmMArOQnDoL4dRZCKcu
        YGRexSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGF/bDmv172B8vCT+EKMAB6MSD+8O
        zhlRQqyJZcWVuYcYJTiYlUR4T2+fFiXEm5JYWZValB9fVJqTWnyIUZqDRUmclz//WKSQQHpi
        SWp2ampBahFMlomDU6qBcfasB8ZcmrenPnJqTMtjKIgMZfqkfnQ5083CvWtESsUdS87sj3H8
        u0O48Lq4WoxESmiMdsq36lur1OuXKT24tbXjzTSOwks/t+xVONBWPEfu95KU/6uelRz1/bp0
        Trvxzsy/ZocjVJmvzJeYZ9CS7/PKQL70wsMHYiv3fE/n4dLeULZpfckTTyWW4oxEQy3mouJE
        AJwIa+SrAgAA
X-CMS-MailID: 20180302002944epcas2p4b7ea411d073312918bfa43e1d0c86042
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180227071142eucas1p10203dac2558db034a4a3287220213601
X-RootMTR: 20180227071142eucas1p10203dac2558db034a4a3287220213601
References: <20180227071134.28063-1-a.hajda@samsung.com>
        <CGME20180227071142eucas1p10203dac2558db034a4a3287220213601@eucas1p1.samsung.com>
        <20180227071134.28063-7-a.hajda@samsung.com> <5A953C21.5020007@samsung.com>
        <87dd3281-0471-ab2a-90c6-3f2d4bdf4750@samsung.com>
        <5A95DB2B.6000003@samsung.com>
        <54edf1d7-056f-ad75-4d94-e1efa2ffdc1c@samsung.com>
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018년 02월 28일 22:44, Andrzej Hajda wrote:
> On 27.02.2018 23:26, Chanwoo Choi wrote:
>> Hi,
>>
>> On 2018년 02월 27일 21:05, Andrzej Hajda wrote:
>>> On 27.02.2018 12:08, Chanwoo Choi wrote:
>>>> Hi,
>>>>
>>>> On 2018년 02월 27일 16:11, Andrzej Hajda wrote:
>>>>> From: Maciej Purski <m.purski@samsung.com>
>>>>>
>>>>> Currently MHL chip must be turned on permanently to detect MHL cable. It
>>>>> duplicates micro-USB controller's (MUIC) functionality and consumes
>>>>> unnecessary power. Lets use extcon attached to MUIC to enable MHL chip
>>>>> only if it detects MHL cable.
>>>>>
>>>>> Signed-off-by: Maciej Purski <m.purski@samsung.com>
>>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>>> ---
>>>>> v5: updated extcon API
>>>>>
>>>>> This is rework of the patch by Maciej with following changes:
>>>>> - use micro-USB port bindings to get extcon, instead of extcon property,
>>>>> - fixed remove sequence,
>>>>> - fixed extcon get state logic.
>>>>>
>>>>> Code finding extcon node is hacky IMO, I guess ultimately it should be done
>>>>> via some framework (maybe even extcon), or at least via helper, I hope it
>>>>> can stay as is until the proper solution will be merged.
>>>>>
>>>>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>>>>> ---
>>>>>  drivers/gpu/drm/bridge/sil-sii8620.c | 97 ++++++++++++++++++++++++++++++++++--
>>>>>  1 file changed, 94 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
>>>>> index 9e785b8e0ea2..62b0adabcac2 100644
>>>>> --- a/drivers/gpu/drm/bridge/sil-sii8620.c
>>>>> +++ b/drivers/gpu/drm/bridge/sil-sii8620.c
>>>>> @@ -17,6 +17,7 @@
>>>>>  
>>>>>  #include <linux/clk.h>
>>>>>  #include <linux/delay.h>
>>>>> +#include <linux/extcon.h>
>>>>>  #include <linux/gpio/consumer.h>
>>>>>  #include <linux/i2c.h>
>>>>>  #include <linux/interrupt.h>
>>>>> @@ -25,6 +26,7 @@
>>>>>  #include <linux/list.h>
>>>>>  #include <linux/module.h>
>>>>>  #include <linux/mutex.h>
>>>>> +#include <linux/of_graph.h>
>>>>>  #include <linux/regulator/consumer.h>
>>>>>  #include <linux/slab.h>
>>>>>  
>>>>> @@ -81,6 +83,10 @@ struct sii8620 {
>>>>>  	struct edid *edid;
>>>>>  	unsigned int gen2_write_burst:1;
>>>>>  	enum sii8620_mt_state mt_state;
>>>>> +	struct extcon_dev *extcon;
>>>>> +	struct notifier_block extcon_nb;
>>>>> +	struct work_struct extcon_wq;
>>>>> +	int cable_state;
>>>>>  	struct list_head mt_queue;
>>>>>  	struct {
>>>>>  		int r_size;
>>>>> @@ -2175,6 +2181,77 @@ static void sii8620_init_rcp_input_dev(struct sii8620 *ctx)
>>>>>  	ctx->rc_dev = rc_dev;
>>>>>  }
>>>>>  
>>>>> +static void sii8620_cable_out(struct sii8620 *ctx)
>>>>> +{
>>>>> +	disable_irq(to_i2c_client(ctx->dev)->irq);
>>>>> +	sii8620_hw_off(ctx);
>>>>> +}
>>>>> +
>>>>> +static void sii8620_extcon_work(struct work_struct *work)
>>>>> +{
>>>>> +	struct sii8620 *ctx =
>>>>> +		container_of(work, struct sii8620, extcon_wq);
>>>>> +	int state = extcon_get_state(ctx->extcon, EXTCON_DISP_MHL);
>>>>> +
>>>>> +	if (state == ctx->cable_state)
>>>>> +		return;
>>>>> +
>>>>> +	ctx->cable_state = state;
>>>>> +
>>>>> +	if (state > 0)
>>>>> +		sii8620_cable_in(ctx);
>>>>> +	else
>>>>> +		sii8620_cable_out(ctx);
>>>>> +}
>>>>> +
>>>>> +static int sii8620_extcon_notifier(struct notifier_block *self,
>>>>> +			unsigned long event, void *ptr)
>>>>> +{
>>>>> +	struct sii8620 *ctx =
>>>>> +		container_of(self, struct sii8620, extcon_nb);
>>>>> +
>>>>> +	schedule_work(&ctx->extcon_wq);
>>>>> +
>>>>> +	return NOTIFY_DONE;
>>>>> +}
>>>>> +
>>>>> +static int sii8620_extcon_init(struct sii8620 *ctx)
>>>>> +{
>>>>> +	struct extcon_dev *edev;
>>>>> +	struct device_node *musb, *muic;
>>>>> +	int ret;
>>>>> +
>>>>> +	/* get micro-USB connector node */
>>>>> +	musb = of_graph_get_remote_node(ctx->dev->of_node, 1, -1);
>>>>> +	/* next get micro-USB Interface Controller node */
>>>>> +	muic = of_get_next_parent(musb);
>>>>> +
>>>>> +	if (!muic) {
>>>>> +		dev_info(ctx->dev, "no extcon found, switching to 'always on' mode\n");
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	edev = extcon_find_edev_by_node(muic);
>>>>> +	of_node_put(muic);
>>>>> +	if (IS_ERR(edev)) {
>>>>> +		if (PTR_ERR(edev) == -EPROBE_DEFER)
>>>>> +			return -EPROBE_DEFER;
>>>>> +		dev_err(ctx->dev, "Invalid or missing extcon\n");
>>>>> +		return PTR_ERR(edev);
>>>>> +	}
>>>>> +
>>>>> +	ctx->extcon = edev;
>>>>> +	ctx->extcon_nb.notifier_call = sii8620_extcon_notifier;
>>>>> +	INIT_WORK(&ctx->extcon_wq, sii8620_extcon_work);
>>>>> +	ret = extcon_register_notifier(edev, EXTCON_DISP_MHL, &ctx->extcon_nb);
>>>> You better to use devm_extcon_register_notifier().
>>> With devm version I risk that in case of device unbind notification will
>>> be called after .remove callback, it seems to me quite dangerous. Or am
>>> I missing something?
>> If you use the cancel_work_sync() in remove() instead of flush_work(),
>> you can use the 'devm_extcon_*'.
> 
> cancel_work_sync() does not prevent works scheduled later from execution
> [1] and this scenario is possible with devm_extcon_register_notifier()
> and cancel_work_sync().
> So we end up with:
>     sii8620_remove() calls cancel_work_sync()
> ...
>     notifier(called asynchronously) schedules sii8620_extcon_work()
> ...
>     notifier is removed by devm framework
>     sii8620 context is destroyed by devm framework
> ...
>     sii8620_extcon_work is executed on destroyed context !!! BUG !!!
> 
> For me it seems that devm_extcon_register_notifier is not safe in this case.
> 
> [1]: Since documentation was not clear I have performed live test
> confirming my suspicions.

You're right. Sorry for confusion.
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

[snip]

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
