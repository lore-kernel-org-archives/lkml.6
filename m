Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751774AbeBDJSQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 04:18:16 -0500
Received: from mail-ot0-f169.google.com ([74.125.82.169]:39885 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBDJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 04:18:08 -0500
X-Google-Smtp-Source: AH8x2251kzLv31TvIM2Y7HSOe4fZPqtMVFAUsLO1G8KVpZrvkEBN/MW5xNskhVaWJfoT0GGZvipGkt3b7J4dM+JcQs8=
MIME-Version: 1.0
In-Reply-To: <CAJZ5v0gj6GT=kuQvTZifktuK887_o98t4voUUK0i_90Hnw0Tpg@mail.gmail.com>
References: <20180122162747.19103-1-ville.syrjala@linux.intel.com> <CAJZ5v0gj6GT=kuQvTZifktuK887_o98t4voUUK0i_90Hnw0Tpg@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sun, 4 Feb 2018 10:18:07 +0100
X-Google-Sender-Auth: ChdqAlp1Oc4WDTJuvHSUWrIzHs8
Message-ID: <CAJZ5v0jKQh-YyjNjCuVqnj_oiPZ+HLLSftd4ECRJ1ZgPiroxSA@mail.gmail.com>
Subject: Re: [PATCH] Revert "cpuidle: Make drivers initialize polling state"
To: Ville Syrjala <ville.syrjala@linux.intel.com>
Cc: Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w149INdV030741

On Sun, Feb 4, 2018 at 10:12 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jan 22, 2018 at 5:27 PM, Ville Syrjala
> <ville.syrjala@linux.intel.com> wrote:
>> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
>>
>> This reverts commit 1b39e3f813b4685c7a30ae964d5529a1b0e3a286.
>>
>> Makes my P3 machine oops somewhere in cpuidle. I suspect
>> CONFIG_ACPI=n may have something to do with this.
>
> And if you don't do CONFIG_ACPI=n, does it still oops?
>
> Anyway, there are later changes depending on this one, so reverting it
> won't work in general.
>
> Let me look deeper at this.

What's there in /sys/devices/system/cpu/cpuidle/current_driver on your
system with the problematic commit reverted?
