Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeBSLou (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 06:44:50 -0500
Received: from foss.arm.com ([217.140.101.70]:57862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752528AbeBSLos (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 06:44:48 -0500
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
        Roy Franz <roy.franz@cavium.com>,
        Harb Abdulhamid <harba@codeaurora.org>, Nishanth Menon <nm@ti.com>,
        Loc Ho <lho@apm.com>, Alexey Klimov <klimov.linux@gmail.com>,
        Ryan Harkin <Ryan.Harkin@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Subject: Re: [PATCH v5 05/20] firmware: arm_scmi: add scmi protocol bus to
 enumerate protocol devices
To: Arnd Bergmann <arnd@arndb.de>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-6-git-send-email-sudeep.holla@arm.com>
 <CAK8P3a1wBBVZnd6ns5K-HhQ28WKAwVbaWsnmE+83SyOnTQt4_w@mail.gmail.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <776fa373-f27f-b32b-6c1f-bb10f257ddc7@arm.com>
Date: Mon, 19 Feb 2018 11:44:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1wBBVZnd6ns5K-HhQ28WKAwVbaWsnmE+83SyOnTQt4_w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/18 11:35, Arnd Bergmann wrote:
> On Tue, Jan 2, 2018 at 3:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
> 
>> +#ifdef CONFIG_ARM_SCMI_PROTOCOL
>> +int scmi_driver_register(struct scmi_driver *driver,
>> +                        struct module *owner, const char *mod_name);
>> +void scmi_driver_unregister(struct scmi_driver *driver);
>> +#else
>> +static int scmi_driver_register(struct scmi_driver *driver,
>> +                               struct module *owner, const char *mod_name)
>> +{
>> +       return -EINVAL;
>> +}
>> +static void scmi_driver_unregister(struct scmi_driver *driver) {}
>> +#endif /* CONFIG_ARM_SCMI_PROTOCOL */
> 
> The dummy helpers must be 'static inline', not just 'static', otherwise you
> get a warning when this header is included by a file that doesn't call
> both of them.
> 

Thanks, fixed locally now.

-- 
Regards,
Sudeep
