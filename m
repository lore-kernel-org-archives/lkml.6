Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbeCTJlx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 05:41:53 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:38841 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752015AbeCTJlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 05:41:50 -0400
X-Google-Smtp-Source: AG47ELuyKKUsiU+ho/SN7dzPjKJ4BNQ9J/dxXEIUxf7dd9f5FzsypwWRlUxFGnyANWLxGMYRvcXE5NaqaFImYTaPqus=
MIME-Version: 1.0
In-Reply-To: <d14d48ab-9ba1-c70c-4d46-cd9c7c862add@oracle.com>
References: <20180315142205.15839-1-joao.m.martins@oracle.com>
 <bbf536dc-3c3d-8a25-47e8-7fd52850835d@oracle.com> <d14d48ab-9ba1-c70c-4d46-cd9c7c862add@oracle.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 20 Mar 2018 10:41:49 +0100
X-Google-Sender-Auth: QsMOgOH5wDSEgkLWV5ClT6CmsSY
Message-ID: <CAJZ5v0ipVHsjEBJuj3Lz6iRSVasv8d2YY0qjz1SFaCK+zDP=Xw@mail.gmail.com>
Subject: Re: [PATCH v3] xen/acpi: upload _PSD info for non Dom0 CPUs too
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        xen-devel@lists.xenproject.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 2:57 PM, Joao Martins <joao.m.martins@oracle.com> wrote:
> On 03/15/2018 03:45 PM, Boris Ostrovsky wrote:
>> On 03/15/2018 10:22 AM, Joao Martins wrote:
>>> All uploaded PM data from non-dom0 CPUs takes the info from vCPU 0 and
>>> changing only the acpi_id. For processors which P-state coordination type
>>> is HW_ALL (0xFD) it is OK to upload bogus P-state dependency information
>>> (_PSD), because Xen will ignore any cpufreq domains created for past CPUs.
>>>
>>> Albeit for platforms which expose coordination types as SW_ANY or SW_ALL,
>>> this will have some unintended side effects. Effectively, it will look at
>>> the P-state domain existence and *if it already exists* it will skip the
>>> acpi-cpufreq initialization and thus inherit the policy from the first CPU
>>> in the cpufreq domain. This will finally lead to the original cpu not
>>> changing target freq to P0 other than the first in the domain. Which will
>>> make turbo boost not getting enabled (e.g. for 'performance' governor) for
>>> all cpus.
>>>
>>> This patch fixes that, by also evaluating _PSD when we enumerate all ACPI
>>> processors and thus always uploading the correct info to Xen. We export
>>> acpi_processor_get_psd() for that this purpose, but change signature
>>> to not assume an existent of acpi_processor given that ACPI isn't creating
>>> an acpi_processor for non-dom0 CPUs.
>>>
>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>
>> Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>>
> Thanks!
>
> I suppose what's remaining is review (or ack) from ACPI folks on the interface
> changes made to acpi_processor_get_psd().

There you go:

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Do you want to route this via Xen?
