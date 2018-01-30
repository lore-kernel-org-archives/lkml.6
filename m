Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeA3BpJ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 20:45:09 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:35605
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752440AbeA3BpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 20:45:06 -0500
X-ASG-Debug-ID: 1517276665-093b7e06e8096e0001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: "Yang, Shunyong" <shunyong.yang@hxt-semitech.com>
To: "rjw@rjwysocki.net" <rjw@rjwysocki.net>
CC: "lenb@kernel.org" <lenb@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zheng, Joey" <yu.zheng@hxt-semitech.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Jiang, Yutang2" <yutang2.jiang@hxt-semitech.com>
Subject: Re: [PATCH v2] ACPI / tables: Add IORT to injectable table list
Thread-Topic: [PATCH v2] ACPI / tables: Add IORT to injectable table list
X-ASG-Orig-Subj: Re: [PATCH v2] ACPI / tables: Add IORT to injectable table list
Thread-Index: AQHTlCPb2ARzJ9BNo0O5jf5uTQ8ff6OLKU8A
Date: Tue, 30 Jan 2018 01:44:32 +0000
Message-ID: <1517276662.2652.12.camel@hxt-semitech.com>
References: <1516695922-15045-1-git-send-email-shunyong.yang@hxt-semitech.com>
In-Reply-To: <1516695922-15045-1-git-send-email-shunyong.yang@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.64.6.3]
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <F5732FE6EC49F34AB83E1BE5353D4D01@hxt-semitech.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Barracuda-Connect: localhost[10.128.0.15]
X-Barracuda-Start-Time: 1517276665
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4089 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.47398
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rafael

Could you please help to review this patch? This is a small change to
add ACPI_SIG_IORT to table_sigs[]. 
Loading IORT table from initrd is very useful to debug SMMU node/device
probe, MSI allocation, stream id translation and verifying IORT table
from firmware. So, I add this.

Thanks
Shunyong.

On Tue, 2018-01-23 at 16:25 +0800, Yang Shunyong wrote:
> This patch adds ACPI_SIG_IORT to the table, which enables IORT from
> initrd to override which from firmware.
> 
> Signed-off-by: Yang Shunyong <shunyong.yang@hxt-semitech.com>
> Cc: yutang2.jiang@hxt-semitech.com
> Cc: yu.zheng@hxt-semitech.com
> ---
> 
> v2: change typo ACPI_SIG_PPTT to ACPI_SIG_IORT in commit message.
> 
> ---
>  drivers/acpi/tables.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 80ce2a7d224b..7bcb66ccccf3 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -456,7 +456,8 @@ static u8 __init acpi_table_checksum(u8 *buffer,
> u32 length)
>  	ACPI_SIG_SLIC, ACPI_SIG_SPCR, ACPI_SIG_SPMI, ACPI_SIG_TCPA,
>  	ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
>  	ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
> -	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, NULL };
> +	ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
> +	NULL };
>  
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>  
