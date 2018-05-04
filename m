Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbeEDL4P convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 07:56:15 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:37362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751060AbeEDL4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 07:56:13 -0400
From: Shiju Jose <shiju.jose@huawei.com>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>
CC: "alex_gagniuc@dellteam.com" <alex_gagniuc@dellteam.com>,
        "austin_bolen@dell.com" <austin_bolen@dell.com>,
        "shyam_iyer@dell.com" <shyam_iyer@dell.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        Tyler Baicar <tbaicar@codeaurora.org>,
        Will Deacon <will.deacon@arm.com>, James Morse <james.morse@arm.com>,
        "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>,
        gengdongjiu <gengdongjiu@huawei.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "devel@acpica.org" <devel@acpica.org>
Subject: RE: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Thread-Topic: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
 ghes_cper_severity()
Thread-Index: AQHT4MsCQf6Nt4waY0S65Mk3QcBWH6Qfd+HA
Date: Fri, 4 May 2018 11:56:03 +0000
Message-ID: <86258A5CC0A3704780874CF6004BA8A64EE2C974@FRAEML521-MBX.china.huawei.com>
References: <20180430212836.7807-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-1-mr.nuke.me@gmail.com>
 <20180430213358.8319-2-mr.nuke.me@gmail.com>
In-Reply-To: <20180430213358.8319-2-mr.nuke.me@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.226.53]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

> -----Original Message-----
> From: Alexandru Gagniuc [mailto:mr.nuke.me@gmail.com]
> Sent: 30 April 2018 22:34
> To: bp@alien8.de
> Cc: alex_gagniuc@dellteam.com; austin_bolen@dell.com;
> shyam_iyer@dell.com; Alexandru Gagniuc; Rafael J. Wysocki; Len Brown;
> Tony Luck; Mauro Carvalho Chehab; Robert Moore; Erik Schmauss; Tyler
> Baicar; Will Deacon; James Morse; Shiju Jose; Jonathan (Zhixiong) Zhang;
> gengdongjiu; linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-edac@vger.kernel.org; devel@acpica.org
> Subject: [RFC PATCH v4 2/3] acpi: apei: Rename ghes_severity() to
> ghes_cper_severity()
> 
> ghes_severity() is a misnomer in this case, as it implies the severity
> of the entire GHES structure. Instead, it maps one CPER value to a
> monotonically increasing number. ghes_cper_severity() is clearer.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/acpi/apei/ghes.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index f9b53a6f55f3..c9f1971333c1 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -271,7 +271,7 @@ static void ghes_fini(struct ghes *ghes)
>  		unmap_gen_v2(ghes);
>  }
> 
> -static inline int ghes_severity(int severity)
> +static inline int ghes_cper_severity(int severity)

[...]
>  	else
>  		ratelimit = &ratelimit_uncorrected;
> @@ -705,9 +705,8 @@ static int ghes_proc(struct ghes *ghes)
>  	if (rc)
>  		goto out;
> 
> -	if (ghes_severity(ghes->estatus->error_severity) >=
> GHES_SEV_PANIC) {
> +	if (ghes_cper_severity(ghes->estatus->error_severity) >=
> GHES_SEV_PANIC)
>  		__ghes_panic(ghes);

PCIe AER fatal errors result panic here.
I think ghes_cper_severity to be replaced with ghes_severity in the ghes_proc function as well in the patch 
"acpi: apei: Do not panic() on PCIe errors reported through GHES"?
> -	}
> 
[...]
> 2.14.3

Thanks,
Shiju
