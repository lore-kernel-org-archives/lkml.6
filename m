Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06BC5C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B8D72178F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 17:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPa+2Ec+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8D72178F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729478AbeHDTVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 15:21:54 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41363 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHDTVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 15:21:54 -0400
Received: by mail-pf1-f193.google.com with SMTP id y10-v6so4835198pfn.8;
        Sat, 04 Aug 2018 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=PQyQS929tzCkCRRLMSYGuMb48igEqErM2m3zoywlAB8=;
        b=jPa+2Ec+y4+GrpIv9zKkTRGDjCGFiWePaYQbLW92T5Bg1n8E5c6VVB31LBqkZtd8eN
         AOVrMUjFMnNArdbz1cRo1XvaGImZRhPHkm9VKH42+rd1H1V7uD4y2lLt1eFcSNN/9yky
         Ox+PciVtbE2I3FOAhwhI+5tOoeueBbhQxt3+mWzRNaH8B80x6EyKbfRKg0NJYm0xQfV8
         IXzmWueI/GfF7On5lvPqqoHN2Gimftdd8h5+SNEmT4mZ9vPVin40aGGuFF/Gu6BFSU3j
         rWxtmvrCmAsdiWod8/oOA5AuxOmrth6pzFPKefdvyoFHg3ojyPOW3JWmj3v03yKfuj6k
         hUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=PQyQS929tzCkCRRLMSYGuMb48igEqErM2m3zoywlAB8=;
        b=s1mbIuCMAHGr/uzwe3yyQWh3md/PlyzL9UcsqZ2xnoyWYWCM1QM2Sn1xFVqFn6s0aF
         YP/Nk7T8XWNQnceIR3EmY3W2hriP1jRJY49tUDc8Yy/J6q2yNbV+2PADEIpykHg7N+B0
         98g2lEhkF7QeG061aAV6hXxL5pUjOKz+DGngJKIV5Iv5sGPv3bIz6Yr5ZyUVW4VWfuay
         vj/L9dTK6vHB15DH4iuxsxlOSkrrPimN8g+4oMw4Ognoja87elbk+vkNOrINQ2IFyj3U
         h0oGH7qenoJDQvjdaqSvTdP6X1krTjmPzlR/jT5iyDXGG1T5b9d2b35EzR3fa5+X0JML
         tReg==
X-Gm-Message-State: AOUpUlGSEJsS8f8M+co3Q/UhZ6muSNbA6CRzKuGNmVHVdYVaWZL43Q1C
        vM8DxrGOCFn77jPddziZDqGGuP4I
X-Google-Smtp-Source: AAOMgpeNm4X1oDUJFo7URd+M6MR5O4kjR6Bj1cmhijRm0aPgubFSDMjYFxyxSs20r1wZnRl8HwDrHA==
X-Received: by 2002:a63:6cc8:: with SMTP id h191-v6mr8356742pgc.359.1533403232628;
        Sat, 04 Aug 2018 10:20:32 -0700 (PDT)
Received: from [192.168.1.54] (c-98-210-181-167.hsd1.ca.comcast.net. [98.210.181.167])
        by smtp.gmail.com with ESMTPSA id q140-v6sm11126006pgq.11.2018.08.04.10.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 10:20:31 -0700 (PDT)
Subject: Re: [PATCH v6 16/17] media: v4l2: async: Remove notifier subdevs
 array
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>, linux-media@vger.kernel.org,
        Steve Longerbeam <steve_longerbeam@mentor.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Sebastian Reichel <sre@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
 <1531175957-1973-17-git-send-email-steve_longerbeam@mentor.com>
 <20180723123557.bfxxsqqhlaj3ccwc@valkosipuli.retiisi.org.uk>
 <a040c77f-2bee-5d0d-57ec-852ff30448e9@gmail.com> <20180804103354.GB9285@w540>
From:   Steve Longerbeam <slongerbeam@gmail.com>
Message-ID: <1c2ca684-3de6-d709-2daa-04acdc54846a@gmail.com>
Date:   Sat, 4 Aug 2018 10:20:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180804103354.GB9285@w540>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,


On 08/04/2018 03:33 AM, jacopo mondi wrote:
> Hi Steve,
>
> On Mon, Jul 23, 2018 at 09:44:57AM -0700, Steve Longerbeam wrote:
>>
>> On 07/23/2018 05:35 AM, Sakari Ailus wrote:
>>> Hi Steve,
>>>
>>> Thanks for the update.
>>>
>>> On Mon, Jul 09, 2018 at 03:39:16PM -0700, Steve Longerbeam wrote:
>>>> All platform drivers have been converted to use
>>>> v4l2_async_notifier_add_subdev(), in place of adding
>>>> asd's to the notifier subdevs array. So the subdevs
>>>> array can now be removed from struct v4l2_async_notifier,
>>>> and remove the backward compatibility support for that
>>>> array in v4l2-async.c.
>>>>
>>>> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
>>> This set removes the subdevs and num_subdevs fieldsfrom the notifier (as
>>> discussed previously) but it doesn't include the corresponding
>>> driver changes. Is there a patch missing from the set?
>> Hi Sakari, yes somehow patch 15/17 (the large patch to all drivers)
>> got dropped by the ML, maybe because the cc-list was too big?
>>
>> I will resend with only linux-media and cc: you.
> For the Renesas CEU and Renesas R-Car VIN you can add my:
>
> Tested-by: Jacopo Mondi <jacopo+renesas@jmondi.org>

Thanks for testing!

>
> I would have a very small comment on the renesas-ceu.c patch. I'm copying
> the hunk here below as the patch didn't reach the mailing list
>
>> @@ -1562,40 +1557,46 @@ static int ceu_parse_dt(struct ceu_device *ceudev)
>>                         dev_err(ceudev->dev,
>>                                 "No subdevice connected on endpoint %u.\n", i);
>>                         ret = -ENODEV;
>> -                       goto error_put_node;
>> +                       goto error_cleanup;
>>                 }
>>
>>                 ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &fw_ep);
>>                 if (ret) {
>>                 if (ret) {
>>                         dev_err(ceudev->dev,
>>                                 "Unable to parse endpoint #%u.\n", i);
>> -                       goto error_put_node;
>> +                       goto error_cleanup;
>>                 }
>>
>>                 if (fw_ep.bus_type != V4L2_MBUS_PARALLEL) {
>>                         dev_err(ceudev->dev,
>>                                 "Only parallel input supported.\n");
>>                         ret = -EINVAL;
>> -                       goto error_put_node;
>> +                       goto error_cleanup;
>>                 }
>>
>>                 /* Setup the ceu subdevice and the async subdevice. */
>>                 ceu_sd = &ceudev->subdevs[i];
>>                 INIT_LIST_HEAD(&ceu_sd->asd.list);
>>
>> +               remote = of_graph_get_remote_port_parent(ep);
>>                 ceu_sd->mbus_flags = fw_ep.bus.parallel.flags;
>>                 ceu_sd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
>> -               ceu_sd->asd.match.fwnode =
>> -                       fwnode_graph_get_remote_port_parent(
>> -                                       of_fwnode_handle(ep));
>> +               ceu_sd->asd.match.fwnode = of_fwnode_handle(remote);
>> +
>> +               ret = v4l2_async_notifier_add_subdev(&ceudev->notifier,
>> +                                                    &ceu_sd->asd);
>> +               if (ret) {
>> +                       of_node_put(remote);
>                          ^^^ The 'remote' device node is only put in
>                          the error path

If v4l2_async_notifier_add_subdev() succeeds, then the reference
is kept on the remote node until the asd is freed in
v4l2_async_notifier_cleanup(). Otherwise if
v4l2_async_notifier_add_subdev() fails, the asd is not
added to the notifier asd_list so the caller is responsible
for putting the remote node. So the only case where
the remote needs to be put is in the line you marked above.
Otherwise in the other error-out paths, the remote nodes
for all asd's that have been added will be put below in the
error_cleanup path.

Steve


>> +                       goto error_cleanup;
>> +               }
>>
>> -               ceudev->asds[i] = &ceu_sd->asd;
>>                 of_node_put(ep);
>>         }
>>
>>         return num_ep;
>>
>> -error_put_node:
>> +error_cleanup:
>> +       v4l2_async_notifier_cleanup(&ceudev->notifier);
>>         of_node_put(ep);
>>         return ret;
>> }
> Thanks
>     j

