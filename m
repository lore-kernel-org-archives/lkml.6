Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03AA3C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B040D208E2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="txsmJ7S+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J0nrLxTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B040D208E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732413AbeGJW5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 18:57:00 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36066 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732328AbeGJW47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 18:56:59 -0400
Received: by mail-ua0-f194.google.com with SMTP id y8-v6so15049126uan.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 15:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZFRmDSfeqHNRV/cOLec/5MNSDqI0ega8FN+QwrsydaY=;
        b=txsmJ7S+vvaRJUcGBkXxElxznmy7bOtZtai9E+qRmxekOW/1GdDkOYJML+3p+gXYve
         SPxqUMETbpy3HkdXFvpiVqJRfMILUDDnw+EMzBiB+4JCX5eCc3xXp5a0VoXlXoPu/feG
         ZxHZvn8iTMi24mGulVIEaM/5FQhas9qDB85KW5dGeW9/wbPeqiSqwW+bLntqLYDh1W51
         /zgSqN5WYpjtD3Oho6MxnMg8Tc1Z95orFHY7p87mSuOOfkUb7oaVqCbjYoad3ReMiopk
         TB+mgp+iuQxg6JMuXH8LMlOB9JJRyJcPe7gWLPHxSv5mfxCRhdDJog7NxkQQBFIfThP9
         KheA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZFRmDSfeqHNRV/cOLec/5MNSDqI0ega8FN+QwrsydaY=;
        b=J0nrLxTIW6d6IR639ss5ueCtBF4wwAn0+n7LYi1XmuoHEJ/WzcmQdUJbYLDVCnHzXi
         WBgQ+n8nsg3aHTOdzcy19moD5dM0CablRm9/gp3Z5GraDELyHA4vZNNySCIeQOEfH8HO
         eLzaIndvRSA90MvCFVzR6DgRCd4aXvNBzR5oE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZFRmDSfeqHNRV/cOLec/5MNSDqI0ega8FN+QwrsydaY=;
        b=eMWG5RxZQAbYhL3tVz5TLWxB+Kpugn5Ui+GLDkId4dBA4dRWfMDpOzIMy8MpQaP4u0
         XbtxLC71Ppetr/UTryukGsEFPr1y44JoqCBz0tZ8XbrKIXVkHzhXRxI++WPzuT/Ixj3v
         1I6R10IqmwcWbAUfUh/Jlf/DlOy0WkPrLQ3KcgKL4aZYxO0Tq+bc5eocaL4ZX8mfikbS
         7ViENUSmNxwKXbDRC8EO94wBow1ps0AMK52PFG56K3wlXQrh4MS6ltgnP5dUWD06dlqr
         Nbt4qzjmvwYRJdam2RvPQhEmzKqAM6qL3PA9X9Ul9DK3RPFRzgm/eND+wc0HApZFRfa9
         9EBg==
X-Gm-Message-State: APt69E0WpGqgpXTWw0U3sweiSpQ5gk3sYbdZcNnXj9X9KCllL3ExfMZM
        Mc5snP0uCacMAgQexZNETHr2UihT6PkC7yYhHYAt1w==
X-Google-Smtp-Source: AAOMgpf/RdO+muK9wOP9/MX5YZDSlNVf1bZzUzeK1bXSdHdUU7HwBgsbFBJni/LrGpmFZxjDV5gqLzZIaJ3S1CjUkt4=
X-Received: by 2002:ab0:1163:: with SMTP id g35-v6mr16684404uac.135.1531263340982;
 Tue, 10 Jul 2018 15:55:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1f:9495:0:0:0:0:0 with HTTP; Tue, 10 Jul 2018 15:55:40
 -0700 (PDT)
In-Reply-To: <0d334051-2ba5-075d-df8c-affe3e617e8d@codeaurora.org>
References: <20180710220202.116404-1-dianders@chromium.org>
 <20180710220202.116404-3-dianders@chromium.org> <0d334051-2ba5-075d-df8c-affe3e617e8d@codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 10 Jul 2018 15:55:40 -0700
X-Google-Sender-Auth: E9rkyIyu4TIBkZXh_DjyiuOa4lk
Message-ID: <CAD=FV=X5oVYYyZvTNZjvpY+Vss4TzpZwCzSsup0AJOcfAVhkzA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sdm845-mtp: Add RPMh VRM/XOB regulators
To:     David Collins <collinsd@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Tue, Jul 10, 2018 at 3:32 PM, David Collins <collinsd@codeaurora.org> wrote:
> Hello Doug,
>
> On 07/10/2018 03:02 PM, Douglas Anderson wrote:
> ...
>> +             vdd-s1-supply = <&vph_pwr>;
>> +             vdd-s2-supply = <&vph_pwr>;
>> +             vdd-s3-supply = <&vph_pwr>;
>> +             vdd-s4-supply = <&vph_pwr>;
>> +             vdd-s5-supply = <&vph_pwr>;
>> +             vdd-s6-supply = <&vph_pwr>;
>> +             vdd-s7-supply = <&vph_pwr>;
>> +             vdd-s8-supply = <&vph_pwr>;
>> +             vdd-s9-supply = <&vph_pwr>;
>> +             vdd-s10-supply = <&vph_pwr>;
>> +             vdd-s11-supply = <&vph_pwr>;
>> +             vdd-s12-supply = <&vph_pwr>;
>> +             vdd-s13-supply = <&vph_pwr>;
>> +             vdd-l1-l27-supply = <&vreg_s7a_1p025>;
>> +             vdd-l2-l8-l17-supply = <&vreg_s3a_1p35>;
>> +             vdd-l3-l11-supply = <&vreg_s7a_1p025>;
>> +             vdd-l4-l5-supply = <&vreg_s7a_1p025>;
>> +             vdd-l6-supply = <&vph_pwr>;
>> +             vdd-l7-l12-l14-l15-supply = <&vreg_s5a_2p04>;
>> +             vdd-l9-supply = <&vreg_bob>;
>> +             vdd-l10-l23-l25-supply = <&vreg_bob>;
>> +             vdd-l13-l19-l21-supply = <&vreg_bob>;
>> +             vdd-l16-l28-supply = <&vreg_bob>;
>> +             vdd-l18-l22-supply = <&vreg_bob>;
>> +             vdd-l20-l24-supply = <&vreg_bob>;
>> +             vdd-l26-supply = <&vreg_s3a_1p35>;
>> +             vin-lvs-1-2-supply = <&vreg_s4a_1p8>;
>
> I would suggest not specifying any of these regulator parent supplies in
> device tree.  RPMh will be enforcing all regulator parent-child
> dependencies.  Therefore, handling the dependencies in Linux is redundant.
>  It will result in additional RPMh requests as well as more time spent in
> regulator framework calls.  Overall, it will lead to slightly lower
> performance.  Note that while specifying the parent supplies results in
> less efficient runtime behavior, it is not technically wrong so you could
> keep them in place if you prefer.

Interesting.  ...so RPMh will automatically turn on parent regulators
when their children are enabled (assuming that the parent regulator is
also RPMh controlled)?

Personally I'd still prefer to see Linux managing its own state and
relying less on RPMh-automatic stuff, but I'd defer to Bjorn / Andy
(or others) to override me.

-Doug
