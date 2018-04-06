Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1200889-1523013491-2-12203984035523979511
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES ensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523013490; b=qaxUQZy9EemdmL0c9xvUJOVtvjPcgxSj5SAyHwUWbfzlQNuaZD
    +VhEsjnLTj8/wXyL3YP+sv+r8i5qR+v4Y+okd+1vqgEdHwm/6KiVD4fWfER+3csR
    khkZuOycV2Mu9iMIugzTaQBHJlQmBTAzf9d0zrI4AXlkZQovPyFHFRuBDv4YrTjz
    SllTPazi+8h0TbC+l6Rwwy3dnuD45irvTAbkUDoweooLkop5qHTRvI2h3jjO0Ydo
    VKBhA0K+4vj7uk68RnmxIIl+VNKMdqCTS8mKr5bkVlk3aLN580fK7S4MUpmre+Al
    t3fibDdMX9kkxOZIh/eXVaouAsjK3JHNnmYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523013490; bh=5lwLQ
    pzrARZ1LSNZxSZOZS2P09aRUzmWfA+BxHz5nn0=; b=LPO8K9KyEloiO3SNvBwp8
    5XtyqppRiFZy1MXayBbmBki/rb9E8N8oVTbE3zD/qEG2Y17MU0sXqbTFVXLm30Mq
    vdSF8XUJ6sXtbBspvTRSHZmMRELDAwfzCq82NW52ciHsAkB4SrD2yvqmxvt72H8a
    gwCedESurgSKDYdO/Wz4NsxxmheUkldAUpKKZ3bKnpsXzXFVgnmyphIPGHvOQdn3
    idqHQiqF+Jddlz5r+i+RGJ+wWqSjqdlEX3jsqyfV9atytz7oXERP0jJkj8Xf6lHg
    lSQ0oZsJKBHomMzD2dUy4OL877RS6LF6BxzONa2FRTYAhYWyN5hZ2UY0vaRp/lal
    g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ScdTdhBe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p8cS5ajP;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ScdTdhBe x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=p8cS5ajP;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJiZPvGlQrvGBCyCMQQapb/QBfC6ktp5M1ux1rRsi6rMyFXaqW4mnYR6U6PXZRsUJEDp/zpRJ8io4jCTaI4PyrNKCix346zjluc1D48fffo1dDd2SFHr
    G6KL+S2WGF5qnrXUSseQQfhoJv9Sxe99RH6/PlJiJ88QlTeoTrwI5+OE7caK2ZMzNVuuNid1Mvh1wEiAy+VumtHw7U2T/NKRbE/VNWJh3hsrh5qzG2F9mBZj
    9OTs7c9TnUFP4iURZxRtJg==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=fkcnCAHSEhkA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=orOaanDUxKhfy2RhKzgA:9 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx4+vGoboEmMFcsGnhIXXVX4B+Et3Dqr5JnFk3ZgnhgP8XF3eJp5ZvIQmHhR7kQzuw8kMgrhrd48CRRcnLVwOYA8=
MIME-Version: 1.0
In-Reply-To: <20180406110922.GA14674@stallman>
References: <20180406110922.GA14674@stallman>
From: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date: Fri, 6 Apr 2018 16:47:42 +0530
Message-ID: <CAAs3649ctGw6MdYsnDd2CkHW0VFuUqXc0aRwAzav+YWHN2yEPA@mail.gmail.com>
Subject: Re: [PATCH v3] staging: greybus: Fix warning to limit chars per line
To: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Mark Greer <mgreer@animalcreek.com>,
 linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org,
 Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 6, 2018 at 4:39 PM, Gaurav Dhingra
<gauravdhingra.gxyd@gmail.com> wrote:
> Wrap comment to fix warning "prefer a maximum 75 chars per line"
>
> Signed-off-by: Gaurav Dhingra <gauravdhingra.gxyd@gmail.com>
> ---
> Changes in v2:
>     - use correct format for multiline comment
> Changes in v3:
>     - include commit log
> ---
>  drivers/staging/greybus/audio_codec.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/greybus/audio_codec.h b/drivers/staging/greybus/audio_codec.h
> index a1d5440..4efd8b3 100644
> --- a/drivers/staging/greybus/audio_codec.h
> +++ b/drivers/staging/greybus/audio_codec.h
> @@ -23,7 +23,10 @@ enum {
>         NUM_CODEC_DAIS,
>  };
>
> -/* device_type should be same as defined in audio.h (Android media layer) */
> +/*
> + * device_type should be same as defined in audio.h
> + * (Android media layer)
> + */

Acked-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>

--
thanks,
./va
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
