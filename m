Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45059C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3E422B47
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 19:20:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duHivTqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3E422B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934680AbeGFTUZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 15:20:25 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:44561 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933150AbeGFTUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 15:20:23 -0400
Received: by mail-yw0-f194.google.com with SMTP id k18-v6so4547496ywm.11;
        Fri, 06 Jul 2018 12:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5IqK9fU+DCDlQ3Ffd0v+5H6Dgk5Ukd+5YRue9hkXqDI=;
        b=duHivTqK34UnfixvfuKQG2YDgxycY+Tqz/fe0uRRE+Q+6YbRA/IbiacUsuQGzMPeK0
         uI/ivSxGNWL1qgO4CJ1+HgF7774id8g3mbiW7Sm+NC4P/CmcS/rBGrzjnt/8gFO54oHq
         gFTEdxxehJlqKwX2M0hcRYR6qUkFVulBXB7/zVL95+ILmfdDXHV4VMBZVY3jh5e72F6x
         sOIfCwdkKXiQn3IqzsC+hy8uFSP1G4BqUzWImBbPvTTjwnNbkkr6Dh/jXjHfbiEWbYJX
         P9rIokEtfLtVQzPDRe5j4AB5mZauCdib9BJP+XJQn5oj/jIfc3+H2hmX1mbMZR2ZCz87
         LqTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5IqK9fU+DCDlQ3Ffd0v+5H6Dgk5Ukd+5YRue9hkXqDI=;
        b=NZiOrddOEemC1tTOcPtvp5b1dJAPVy+Jz42L/sIMFuF4wGN7mEz7I1UfOvyG/68aFI
         7kwoxFc+HSL3P0b6d2uhakhOPbM2im6YRT29LbnSBEO5FHRPeYW1+FACWd4/siH1LeEJ
         SWhKTbsN3gxDFULgbTT345QJm8/o62ah9a8O3oMJR1unjz7sgbLPOLxh3Z/TAmEEapBX
         i5Y0qUVp88pq6IFd0vuWlpZE4ZoQTypJDzJY50zVfo8VtOM1gAHsY17Dgconabro8+ct
         Qj4tmwFfLvqqJJUlVpmXWovr7q6v5sMmI6V3Y7Mohcg6/FmGWtdaZvPMGjnmUFPqavjw
         e7tA==
X-Gm-Message-State: APt69E01kic/X6P2smvPYDUYr5vhjew4TgDyg7/pqtOg6j+BFYLn2smv
        Zc3Pj9HvSw6ETqEWKqJGflQ=
X-Google-Smtp-Source: AAOMgpfIVx9dr8gWKBu96vAw9Y66edtaGhmp+n+gSX/5u7Duaw7rLBsJhN1JYRQcnhI9OCobfCEWgQ==
X-Received: by 2002:a81:9f51:: with SMTP id w78-v6mr5502882ywg.334.1530904822155;
        Fri, 06 Jul 2018 12:20:22 -0700 (PDT)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id o11-v6sm3836769ywm.107.2018.07.06.12.20.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Jul 2018 12:20:21 -0700 (PDT)
Date:   Fri, 6 Jul 2018 15:20:13 -0400
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     David Lechner <david@lechnology.com>
Cc:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 00/10] Introduce the Counter subsystem
Message-ID: <20180706192013.GA6810@sophia>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
 <603b0373-f1e1-5938-fa53-8328c9a5964f@lechnology.com>
 <20180703024835.GA9493@sophia>
 <20180706182154.0000002d@huawei.com>
 <59b0950e-ef39-4ad4-a32b-316992e1f236@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <59b0950e-ef39-4ad4-a32b-316992e1f236@lechnology.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 01:22:57PM -0500, David Lechner wrote:
>On 07/06/2018 12:21 PM, Jonathan Cameron wrote:
>> On Mon, 2 Jul 2018 22:48:35 -0400
>> William Breathitt Gray <vilhelm.gray@gmail.com> wrote:
>>> Is frequency useful for other
>>> applications on its own (perhaps velocity of an automobile device
>>> equipped with an encoder wheel for some reason or other)?
>
>Since we are just dealing with counters here, I think we should call
>it "rate" instead of "frequency". At least that seems to be the common
>name in industrial automation.
>
>Another possible use case for "rate" would be flow meters. Some
>flow meters generate a pulse every X gallons. Assuming that the
>counter also has a rate output, then you can scale the rate (e.g.
>counts/second) into flow in gallons per minute.
>
>>>
>>> Once we figure out how this data is used, we can determine the best
>>> design and place to introduce it into the Generic Counter interface,
>>> then move on to integration from there.
>> 
>> Great - as long as this fits reasonably well in ABI wise (whatever the
>> details) sounds like we don't need to solve it today.  I'm anxious not
>> to delay merging this counter subsystem for another cycle.
>
>Certainly don't delay things on account of me. I'm just trying to get
>a feel for where things are headed since I missed the earlier discussions.
>I don't see any major problems with the current state of things.
>
>Once this lands, I may have a go at the eQEP and see how it looks.

No worries, it looks like your application would be served well by the
Generic Counter interface, and exposing a "rate" value would be a simple
feature to add. However, since this patchset has been stabilizing over
the past few revisions, I want to postpone the addition of new features
until this interface and its current feature set is merged.

David, once this introduction patchset has been merged, submit to me a
patch adding the "rate" functionality feature and we'll continue
discussing it there.

William Breathitt Gray
