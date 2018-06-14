Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A1E3BC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4085E208B5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 03:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PMGoAlys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4085E208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936038AbeFNDja (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 23:39:30 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38322 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935864AbeFNDj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 23:39:28 -0400
Received: by mail-oi0-f67.google.com with SMTP id d5-v6so4384874oib.5;
        Wed, 13 Jun 2018 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:openpgp:autocrypt:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=KfIoPW3SNvUti2MG+32XvhJV8ICkrHpUg1iT1vJh5Es=;
        b=PMGoAlysopWuTkWImOfjDZS5Fjar+v6SBw1kavqOM8NJzqmK2tT2T2mUFnP0CVwtRW
         GfOscshJbUYprwIbWy+Xk0ZBAmQ5kvUk4Ueb59NANXRWud21jZ925GhTwi05CA5d8E9w
         3Mx+aPF9pmxlae7N+b4gKosKGZySNTqpaSUjrOw7gBeKPi7duwqgSfuuZiKi78jW9u0r
         WwRV/aU6lV/PB25n12G2fPthhBUmd00R3AKIMMGMeFS2U+XyV2JcZU65KW5IK2CYZHu+
         B9sLxK+Vm0xbEXGM3gvC0WXSQsb/+s3+LbpzZeI4BV0+bv1kkZo1Ncodmi9/aaCMq/Bp
         glbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:content-language
         :content-transfer-encoding;
        bh=KfIoPW3SNvUti2MG+32XvhJV8ICkrHpUg1iT1vJh5Es=;
        b=ntN1RTMWBmSaEC8BaSVHgMlB6IaDAdyW7MamgDrZ7i3jv0Zm0TA1W2F+HIirbEBmc9
         7h5mKqs+dJuJI8mmJ4KX0ZtLWu80nHw+yl9V1n6gdO8Li3b5+aCVK305hWJySSWdYR9D
         yYBGxdqKOdHRQaMCbqUg1fuirRS+T/zxaTSxHgVuP9FUWh5kmmsHqbVmpRs6FCBr6Vf7
         jMQAnsl3Sgf8Pm3dtr0oNWq4rfExQDiAh8fXLgK1YLwk25JLhIhRxKfe+BTIwbT+Zk88
         1i3YdbmxUlapbuhJLJKXwstoLAej8z595q9fNdefXZn1ExDayZ4imC8E2kvIdHAhYpGM
         nIPg==
X-Gm-Message-State: APt69E3gj/SjqIA9aul86uJgKIS/pOTFUQ12LmjSPf8Qnqja4sDhgYLQ
        LdmQh1H/5lRDhiQsUJ67bAs=
X-Google-Smtp-Source: ADUXVKKBEoYPVT6kwyH1hQuOUxvH6YudxJDvKUiq/lFLckXuh3pls9XdxTMVJSqIe/qj5gpOo0V84g==
X-Received: by 2002:aca:7255:: with SMTP id p82-v6mr456744oic.256.1528947567446;
        Wed, 13 Jun 2018 20:39:27 -0700 (PDT)
Received: from [192.168.1.3] (ip68-109-195-31.pv.oc.cox.net. [68.109.195.31])
        by smtp.gmail.com with ESMTPSA id r8-v6sm1851182oif.25.2018.06.13.20.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 20:39:26 -0700 (PDT)
To:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        bamvor.zhangjian@linaro.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Improving kselfests cross compilation
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
X-Enigmail-Draft-Status: N11100
Message-ID: <19ec8c01-15a0-eca2-cf6c-08c71b670dab@gmail.com>
Date:   Wed, 13 Jun 2018 20:39:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah,

I was giving a shot at building the kselftests from within buildroot [1]
as of Linux be779f03d563981c65cc7417cc5e0dbbc5b89d30 and there are a
number of things that make it still reasonably hard even today:

- 3c545084130c1fd5cf873a5fec3ee29070128e06 ("selftests: sparc64: char:
Selftest for privileged ADI driver") this contains inline assembly that
can only work when building for sparc64, yet this is still being built
irrespective of what ARCH is set to

- each Makefile that requires knowledge of the architecture seems to
duplicate what ARCH should be, this cannot be moved to lib.mk since
Makefiles do expect lib.mk to be included last and/or after they have
done their own overrides, but something like common.mk which contains
CC, ARCH etc. could be useful to avoid the repetition of looking at
uname -m etc. etc.

- some tests' Makefile do seem to hardcode paths to the system's include
instead of accepting a configurable path:

gpio/Makefile:

LDLIBS += -lmount -I/usr/include/libmount

I will try to submit patches in the next days that address the most
obvious issues I listed here, but in order for this effort not to be a
constant whack-a-mole game, there really needs to be at least one or two
architectures that must attempt to cross-compile (and run) those tests
and use that as an acceptance criteria.

Thanks for reading.

[1]:
https://git.buildroot.org/buildroot/tree/package/linux-tools/linux-tool-selftests.mk.in
-- 
Florian
