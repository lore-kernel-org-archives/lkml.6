Return-Path: <rjwysocki@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526119840; cv=none;
        d=google.com; s=arc-20160816;
        b=YYf9Sr23i5XXTHcjCbdt3yiSoWDGJttTY0pe5WacC+z8ar4EWAlRRTX5n7kjIh7iwK
         yyIVEMjETxv4/j6AmP9ZfqcvKA7PkidlIbP+Fbc1Wunat5s+kPHzo4kbYK4CD4q0v6LK
         pch6DOhbwAWvi24tP6VnKAZe6TenNvAHauLm63t42gKl6qSg48PZ3lLJ1AOYFuf21u/z
         jfGKVx563fJQjeggHSh79vs8L9fd0FrD74NBEc2gSKG79H3UZ17mUZEWqV04yHM80ttn
         6bOCZ94N8NP5szwXAaQYMPbhEq2sveF2w2HBN/Metj2Xcxo0L+2s+GFRQfbv5oo4Pmo7
         UZPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DdhhpAErohTtBJKp/rMsICFQ5bdD99AAm2xLnWx8Yck=;
        b=nDnyFS8w6CNXeaJUuwUxBAihRQNjBkRc1YrWiS72diAEqsCJhm9uWISwZs9jmTMyMm
         AzphVJqu1Px6h9lexvFhDI3rz18pS1LadrjpF7Tv6j2SPa9sgkHr1+9kvILC4suPh1bW
         FJjf12gNmsElOe7JmJ63vyY+OXFBQTpWIt+rSLxHSn3kt760P41zLWB0V63WUYfMHEIV
         gQ21Mauof2gePGUixrQpEvUEGRI3LxFeGetVoB2FuqZFKYCVDZnRVQ99JDmD39ac5XCj
         Jki2z5usFhtpCclyXIJBeoOswTiJsNNWrBtRBLity3b4Z9YQxsqbFREv7xH7slZuU2rk
         hz3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Rr2sK8nw;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Rr2sK8nw;
       spf=pass (google.com: domain of rjwysocki@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=rjwysocki@gmail.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
X-Google-Smtp-Source: AB8JxZqlNeD5NUSdxdEbr9R0XAcwgA0sfrV+EkZZVRmOJZyHPbNJ1IxNwH/Ibq5my2ZpdtToz/plsGaELSazZSQNNSI=
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20180511235807.30834-12-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com> <20180511235807.30834-12-jeremy.linton@arm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Sat, 12 May 2018 12:10:40 +0200
X-Google-Sender-Auth: yAYCCcoNEoMtTxYfCvHKEQ0wlDM
Message-ID: <CAJZ5v0giM0W6KJtxArLLm90gi136pBoc_dz0H-5wg24b_ih0Yg@mail.gmail.com>
Subject: Re: [PATCH v9 11/12] ACPI: Add PPTT to injectable table list
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Sudeep Holla <Sudeep.Holla@arm.com>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <Will.Deacon@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Rutland <Mark.Rutland@arm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com, vkilari@codeaurora.org, Al Stone <ahs3@redhat.com>,
	Dietmar Eggemann <Dietmar.Eggemann@arm.com>, Morten Rasmussen <Morten.Rasmussen@arm.com>, palmer@sifive.com,
	Len Brown <lenb@kernel.org>, John Garry <john.garry@huawei.com>, austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com, jhugo@codeaurora.org,
	Ard Biesheuvel <ard.biesheuvel@linaro.org>, Geoffrey Blake <geoffrey.blake@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214171156065873?=
X-GMAIL-MSGID: =?utf-8?q?1600252638510562908?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 12, 2018 at 1:58 AM, Jeremy Linton <jeremy.linton@arm.com> wrote:
> Add ACPI_SIG_PPTT to the table so initrd's can override the
> system topology.
>
> Signed-off-by: Geoffrey Blake <geoffrey.blake@arm.com>
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I'm assuming that this will be routed along with the rest of the series, so

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/acpi/tables.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> index 849c4fb19b03..30d93bf7c6a2 100644
> --- a/drivers/acpi/tables.c
> +++ b/drivers/acpi/tables.c
> @@ -457,7 +457,7 @@ static const char * const table_sigs[] = {
>         ACPI_SIG_UEFI, ACPI_SIG_WAET, ACPI_SIG_WDAT, ACPI_SIG_WDDT,
>         ACPI_SIG_WDRT, ACPI_SIG_DSDT, ACPI_SIG_FADT, ACPI_SIG_PSDT,
>         ACPI_SIG_RSDT, ACPI_SIG_XSDT, ACPI_SIG_SSDT, ACPI_SIG_IORT,
> -       ACPI_SIG_NFIT, ACPI_SIG_HMAT, NULL };
> +       ACPI_SIG_NFIT, ACPI_SIG_HMAT, ACPI_SIG_PPTT, NULL };
>
>  #define ACPI_HEADER_SIZE sizeof(struct acpi_table_header)
>
> --
> 2.13.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
