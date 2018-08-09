Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B988BC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704A7217D2
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uFN5rBMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 704A7217D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730254AbeHIMXi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 08:23:38 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:42883 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHIMXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 08:23:37 -0400
Received: by mail-oi0-f66.google.com with SMTP id b16-v6so8797339oic.9;
        Thu, 09 Aug 2018 02:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jUktyFqPFUVN9E3j8HRGoM7DA8lLGpJdEuBIA8bV7go=;
        b=uFN5rBMdDT73erqlKYfqkjohJpQUAfMpuogWf2n+BpG3RjDGXB9HbxsfaN5itQAiTZ
         9rW2EolA1ZNkY6NytchSpTrti9HQoB+qzBgNNcOKV+GSNFv8eUXqLEtbEeigCBsGpprq
         7XubTg8yJestZb1SaXI4zT/FFIhA64p2p5bfCnFmhxMkvYLZ65dd5f2+mJrwerYsA6h2
         1GpDrBUJ2xLqKNGbGlgaYymxLl+emffvbkw3zxzvgw3HaGMjaMmtHGbDYJTl0CoUE77c
         atSGcoIkJRind5vTZgikEj+nvFozxBvVG4gnOWRi3aF18pKD4wwvArnW8LowqQaFSszN
         O82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jUktyFqPFUVN9E3j8HRGoM7DA8lLGpJdEuBIA8bV7go=;
        b=fOjpDzp6d76/K8lasmK8SEXgmVnN9l1PrD+r8H5+G0LmceqFxRpkb766iIpi5gqvy7
         OB6+rAI2meHb68Pdbo9r2GACmeeyVhuX1P/6Z9+tIr+6AQz86vNXo2n58XUdjCI9U6W/
         cVpwyJMjPWxM4xJ/8AWGsXYzEvwRPxvwj6JKR2z0DEU3j/KwqlYGxE3ccNGW1LsDvm9j
         ILJmFy6o/4h9ccGlk/YFDFRureZpVyL4R4aJmiI4IXmkodzg0fQjQHmvxPDsSRh2PQ72
         r2v6xQmyQkTG6F1D5rNWOcYlLAsivZiz2X9rCo8K2zlJlTfFFWMWRI+tHziyW6c/jK7E
         0UbA==
X-Gm-Message-State: AOUpUlHfuZR8biAPm1YDjSKdncE9KncFTFyv+gI7XBk9+wrChlT6zzVK
        Ah4+6FiRaWj4VrEIyAVT2al46z1GvFq55nd4tT8=
X-Google-Smtp-Source: AA+uWPzgNZlmPe6SHzGhlrFgFcQv62Z/bZNPUjfriffli4cXEy0j+t53F5r7ugVFFhvtw+2Gle5XAJnTgUIy38m1bLU=
X-Received: by 2002:aca:adc6:: with SMTP id w189-v6mr1461622oie.174.1533808770546;
 Thu, 09 Aug 2018 02:59:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:63d2:0:0:0:0:0 with HTTP; Thu, 9 Aug 2018 02:59:30 -0700 (PDT)
In-Reply-To: <f2f9289d-0adb-e165-a23e-696fe985fda4@redhat.com>
References: <20180809091558.4317-1-hdegoede@redhat.com> <20180809091558.4317-2-hdegoede@redhat.com>
 <CAJZ5v0jBxL8n8ce7=qgZmHtc4=zCA3u7ePbXaHfyibeNiNrw+w@mail.gmail.com>
 <7d8c71b9-292e-e51e-d3d3-cb0bb00528b6@redhat.com> <CAHp75VeiC35S=urEL_f-j+ZPVodPHqGJBRYxv2m5inBkuJ=1kQ@mail.gmail.com>
 <f2f9289d-0adb-e165-a23e-696fe985fda4@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 9 Aug 2018 11:59:30 +0200
X-Google-Sender-Auth: Tt5Ke8OJNoqEelPqwRVlqIo0uYA
Message-ID: <CAJZ5v0hvfR=m5GXhSS4Q7DYFS9+BA+EAt9oHOYdxMU-J78dtwQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] ACPI / scan: Initialize status to ACPI_STA_DEFAULT
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-i2c <linux-i2c@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 11:58 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Hi,
>
> On 09-08-18 11:51, Andy Shevchenko wrote:
>>
>> On Thu, Aug 9, 2018 at 12:39 PM, Hans de Goede <hdegoede@redhat.com>
>> wrote:
>>>
>>> On 09-08-18 11:35, Rafael J. Wysocki wrote:
>>>>
>>>> On Thu, Aug 9, 2018 at 11:15 AM, Hans de Goede <hdegoede@redhat.com>
>>>> wrote:
>>
>>
>>>> I've applied the v4 of this patch and I don't think there are any
>>>> changes from it here.
>>>
>>>
>>>
>>> Correct, there were only changes to the 4th patch in the series.
>>>
>>>> As for the rest of the series I'll wait from comments from Wolfram and
>>>> the other reviewers.
>>>
>>>
>>>
>>> Ok, note if you've taken patch 1 you may also want to take patch 3 which
>>> is an ACPI code cleanup made possible by patch 1 and otherwise is
>>> unrelated.
>>
>>
>> I'm under impression Rafael is going to take entire series (at least
>> for patch 4 I'm expecting to give an Ack).
>
>
> As I mentioned in the coverletter, my idea was to have Rafael take
> patches 1-3 and then merge the 4th patch through the platform/x86
> tree. There are only runtime dependencies between the 2 parts and
> merging them independently should not cause any issues.

I can apply the 4th one too if it is ACKed by everyone with a vested interest.
