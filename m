Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030823AbeCANjd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:46014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030646AbeCANjc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:39:32 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F5021782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AG47ELv4aMzahyVr8jX9ERhJRuE7naUXoeg0E/2H5J8l5AS0zPXgbRTJbT6BYdadeatRuJSQyhQ1yHdxFYtHPeZzGTA=
MIME-Version: 1.0
In-Reply-To: <87606ga8bv.fsf@concordia.ellerman.id.au>
References: <20180228224406.7049-1-robh@kernel.org> <87606ga8bv.fsf@concordia.ellerman.id.au>
From: Rob Herring <robh@kernel.org>
Date: Thu, 1 Mar 2018 07:39:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKn3hXaaYYef47afK+E=WUfZyfF6ejGD0vX7C8sNjhdFw@mail.gmail.com>
Message-ID: <CAL_JsqKn3hXaaYYef47afK+E=WUfZyfF6ejGD0vX7C8sNjhdFw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: dts: replace 'linux,stdout-path' with 'stdout-path'
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 7:33 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Rob Herring <robh@kernel.org> writes:
>
>> 'linux,stdout-path' has been deprecated for some time in favor of
>> 'stdout-path'. Now dtc will warn on occurrences of 'linux,stdout-path'.
>> Search and replace all the of occurrences with 'stdout-path'.
>
> This patch looks OK.
>
> But please remember that not all device trees are generated with dtc, we
> still have machines in the wild that have firmware which use
> "linux,stdout-path" and may never be updated.

Absolutely. The core code still supports both.

The only scenario I could come up with is someone has an old
bootloader that only understands linux,stdout-path and modifies it and
they update the dtb. We may end up with both properties with
stdout-path taking preference.

Rob
