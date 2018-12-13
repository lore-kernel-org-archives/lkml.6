Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6F5C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDC820811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 10:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dP9gbePA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEDC820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbeLMKcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 05:32:16 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43056 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728388AbeLMKcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 05:32:15 -0500
Received: by mail-pl1-f194.google.com with SMTP id gn14so864966plb.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 02:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:subject:to
         :references:message-id:from:user-agent:cc:date;
        bh=vwtO4MQIq14BqwhEjonvZtH0evXJlYXczQEJNCtF9MM=;
        b=dP9gbePAcH8TSJipcyBo8WL83lig72W1KwxuJTqF0eUSYjUKe7oML3FMId3G8uO4hO
         HxAaDFvtghugah4lnhBKQWSCTs3FNuJoq5oQ7v5ewr8IgGLeEHKwK+W1URq5xrnaFDk/
         +dWpYfVtvdBDpCD13+KYBg1frlij5Mrzv0bzE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:subject:to:references:message-id:from:user-agent:cc
         :date;
        bh=vwtO4MQIq14BqwhEjonvZtH0evXJlYXczQEJNCtF9MM=;
        b=l1YYSwKUm7u7qAsW+EuBmljuGdmucqNsE+vMk4rS4nNjZWwqvsriAnPcNmvPhpLbcI
         PT/laPCbwk6kp2nGAWBAJ+ISgm38WID1O2hw+VJYIoBYECUFgNhhUjnZ+v1jZlgJl9GC
         23wRrSwibUMaGXLNiet7nP7TcNo5EnwnYECxMk1upSLyyfqfCRoDTiur1iHRitpOXpCF
         hwvHKlpt9OfGyaV/vA6ypX0gJPKOem9IvBd3vjeF4e7sSTi2Yx6t6wlYPwxw95XtNbtw
         TDaB7u2wRJJs/jGBbPMqKGNh48W6QhxFkkiBd2ifXgZuVxntngcmDQfnj8eaa5osPX8F
         Gqww==
X-Gm-Message-State: AA+aEWZZm49Np6vlTFXp7F5hjQcJxwxrUwg0JJjr7/kriv/4IIu55ymr
        G0U6q4XL6ZhsXaNzDvMZSgODz/OwRJ/vxw==
X-Google-Smtp-Source: AFSGD/XrhppyQemO0rIJdjV2A5CX1h60lAVKFZEodvSLrJ8wU/eP+Kv74NxFJetP0fi/Ufgk7ArjAg==
X-Received: by 2002:a17:902:b01:: with SMTP id 1mr23516813plq.331.1544697134627;
        Thu, 13 Dec 2018 02:32:14 -0800 (PST)
Received: from localhost ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id a4sm1687766pgv.70.2018.12.13.02.32.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 02:32:13 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
To:     Viresh Kumar <viresh.kumar@linaro.org>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org> <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com> <20181213100506.sy3haqjbxtmkthvt@vireshk-i7> <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com> <20181213101417.dcz66dpbqzbbxkdz@vireshk-i7>
Message-ID: <154469713309.19322.12951478077195078609@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>,
        devicetree@vger.kernel.org, robh@kernel.org,
        skannan@codeaurora.org, linux-arm-msm@vger.kernel.org,
        evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>
Date:   Thu, 13 Dec 2018 02:32:13 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Viresh Kumar (2018-12-13 02:14:17)
> On 13-12-18, 02:12, Stephen Boyd wrote:
> > It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> > think all it takes is to return an error the second time the policy is
> > initialized when cpufreq_online() calls into the cpufreq driver.
>=20
> What do you mean by "the second time the policy is initialized" ?
>=20
> We call cpufreq_online() only once for each policy.
>=20

I have one policy for four CPUs. So take down all four of those CPUs by
writing a 0 to the online file for each CPU, and then bring them back
online. That should make cpufreq_driver->init() be called twice, once
during boot when the CPUs are bound to the cpufreq devices, and second
from the sysfs write when the user brings the first CPU in that policy
online again by writing a 1 to the online file. If that second time it
fails I suspect we hit the lockdep warning.

I may have also catted the policy*/stat/* files before offlining any
CPUs. If you can't trigger it I can try to reproduce again with a static
counter in cpufreq_online() that fails when set to 1 or something.

