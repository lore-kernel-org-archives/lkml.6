Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68458C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F42208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 09:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPkmXgbM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726816AbfBTJK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 04:10:57 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40484 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfBTJK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 04:10:57 -0500
Received: by mail-pg1-f194.google.com with SMTP id u9so8026140pgo.7;
        Wed, 20 Feb 2019 01:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=lobVKB2HD+mktKdQv+YSyEbIecJtBMxdGXk4f3rVnHc=;
        b=KPkmXgbMHu/+veECUFIml+3dVMN8A2izhOsU10PFJjH6hFlXXRJjAuFKCSs0emNSMa
         ZufhzdtpVanGqYOIgK2GM3KyaAhmkgf3D7pl17m0+71lCyQtYrlGAwWFVgAElnkBNLMT
         fF9gDMtRdOsFAjr9mwvRONsKADtuh8X/8FBZRl3vx33+zdS+PUaFQpyzod3Jib/6ip4D
         6mRLKR1yHW1BRE5LYLjuLchMNYVpUXrxePNGeQhM5/NLfy4m+zMGV70HZJFpkgDD7TI2
         fQIxG/CAcL7gi3d3rIVQfXlpSoeThum5PY6kZFFXhmqVPcGLXtw6lL1F65jaIq7TZT/O
         vROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=lobVKB2HD+mktKdQv+YSyEbIecJtBMxdGXk4f3rVnHc=;
        b=Mz0XBJVxgOPXWoIn0zLEuu2XdDon7DSiy0xniDQYB+lntL8UNQ+S30PeovQAuK8DaM
         snO8y5qyjBXsnbbJzoTVwv5ITYvVFnDPgoY7+xLdmUm1K9E/fWik5n0RFQkMIUefegYO
         MggeF4JXboH+oT77DAgGGMrJVGM9vvGHre3iOzlYlGGL1/UVRnlg4NmqFFp0hR6f00TZ
         W49ngXueyiLXBQyYGbu8dQ9tDqZGXadvFPS33jm0yCje/csnhVcSXwobU1zpFImiVFpB
         +jIC+rP2y9z1ZN4sIIETS5K2mcRtI6E/PpyzbGU+ZyXbO/tuwH4rYHFKZ03ww89hyThh
         tC7Q==
X-Gm-Message-State: AHQUAubmV5c299SI3PVTNCPzPt3Z2rLbjdPm0BuU1sODlj1wb7ZzYMzo
        noGS/ezdfL4uJ0jKfsVge7aY+VgAfWQ=
X-Google-Smtp-Source: AHgI3IazJ/DNb7fj60WoUst7G6wg7YoOgLkjV1ODruwiZX6LA+WU6t4YGL/l+0U+u+rzRPHO/S3n+g==
X-Received: by 2002:a65:5788:: with SMTP id b8mr10856643pgr.8.1550653855611;
        Wed, 20 Feb 2019 01:10:55 -0800 (PST)
Received: from ?IPv6:2405:204:8187:3683:40b0:4750:2bbd:6e4b? ([2405:204:8187:3683:40b0:4750:2bbd:6e4b])
        by smtp.gmail.com with ESMTPSA id n85sm9595988pfj.177.2019.02.20.01.10.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 01:10:54 -0800 (PST)
Subject: Re: [Outreachy kernel] [PATCH] net: dsa: add missing of_node_put
To:     Vaishali Thakkar <vthakkar@vaishalithakkar.in>
Cc:     outreachy-kernel@googlegroups.com,
        Julia Lawall <julia.lawall@lip6.fr>, andrew@lunn.ch,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190220032432.2878-1-himadri18.07@gmail.com>
 <CAK-LDb+pTxoeuVYb+V6N6everYRtOvJwo26O-=LVVEbsXqBOFA@mail.gmail.com>
From:   Himadri Pandya <himadri18.07@gmail.com>
Message-ID: <2068fcd1-abab-b7d4-4f93-cd244230df14@gmail.com>
Date:   Wed, 20 Feb 2019 14:40:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAK-LDb+pTxoeuVYb+V6N6everYRtOvJwo26O-=LVVEbsXqBOFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/02/19 9:23 AM, Vaishali Thakkar wrote:
> On Wed, Feb 20, 2019 at 8:54 AM Himadri Pandya <himadri18.07@gmail.com> wrote:
> Hi Himadri,
>
> Thanks for the patch!
>
> For the scope of Outreachy, we prefer that you send patches in staging
> directory as Greg makes sure to pick them during the application
> period. Of course, you're very much encouraged to contribute to other
> subsystems as well but there patches are mainly picked up based on
> maintainer's cycle which may or may not be picked up for linux-next when
> selection of interns happens.
>
> I hope that makes sense.
Understood. Thank you for letting me know that.
>> Decrement the reference count on port while returning out of the loop.
> How did you find out about this issue?
I believe that Julia Lawall has been working on this for a while. After 
doing some cleanup patches, I'm trying to continue the work with her help.
> I think it would be good to
> give credit to tool in commit log if the issue is identified or produced
> by tool. [In this case, I assume it's Coccinelle]

Yes, it was identified by Coccinelle and I should include it in the 
commit message. Thank you for the remark. I'll revise the patch accordingly.

- Himadri


>> Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
>> ---
>>   net/dsa/dsa2.c | 14 ++++++++++----
>>   1 file changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
>> index a1917025e155..396e7433dd8f 100644
>> --- a/net/dsa/dsa2.c
>> +++ b/net/dsa/dsa2.c
>> @@ -624,19 +624,25 @@ static int dsa_switch_parse_ports_of(struct dsa_switch *ds,
>>          for_each_available_child_of_node(ports, port) {
>>                  err = of_property_read_u32(port, "reg", &reg);
>>                  if (err)
>> -                       return err;
>> +                       goto put_port;
>>
>> -               if (reg >= ds->num_ports)
>> -                       return -EINVAL;
>> +               if (reg >= ds->num_ports) {
>> +                       err = -EINVAL;
>> +                       goto put_port;
>> +               }
>>
>>                  dp = &ds->ports[reg];
>>
>>                  err = dsa_port_parse_of(dp, port);
>>                  if (err)
>> -                       return err;
>> +                       goto put_port;
>>          }
>>
>>          return 0;
>> +
>> +put_port:
>> +       of_node_put(port);
>> +       return err;
>>   }
>>
>>   static int dsa_switch_parse_member_of(struct dsa_switch *ds,
>> --
>> 2.17.1
>>
>> --
>> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
>> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
>> To post to this group, send email to outreachy-kernel@googlegroups.com.
>> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20190220032432.2878-1-himadri18.07%40gmail.com.
>> For more options, visit https://groups.google.com/d/optout.
