Return-Path: <nayna@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZr19e75EbFUZyX61dwWJfEJO2fKY81PHwnVEpOn6KQ9vagQurD4Ez1aUexlEg2sB+Zg12Nf
ARC-Seal: i=1; a=rsa-sha256; t=1526625186; cv=none;
        d=google.com; s=arc-20160816;
        b=sxJbHCeYW2KhX9BjQ8vFH3WB/j26IfABz6hF4mrBd2fkXX68jtJn/xvvGj2+xPha1w
         QQOC6U8s42LzD8Ah1+4KhKpM0/dnnK/9tPMQ3xhUiLLmi+zG9fqCLdysAqwVNb9I6KU0
         Nae7hMIncVakv0Cwmtg6TVVuK6YWG7uaW12soMQgR2+HAkG6kKAVt1MyKgaUSkYAkLIN
         UrTKl76Th51LYhnhUZiriH2gb3C/UoWql9BJDccHnMesfnfqP+Pz8Uc9BdBapksHGB1M
         /9d2pQXK51ZAJrHnq2W2C2I4HCV7t+AswaQ0VqKGpY7zEbzWJzHEyLCWq1P+4ws6iq9Q
         X0cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-language:content-transfer-encoding:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=0ujDC0A1Kn7B76Csz3P/VGizk3aE13ZHHdT7HmraHlY=;
        b=SZOEZD9iu/g0RQvo0+whAMevyW33Am00ocySGOObqxNVekMkTW294QZ/LQHX8HZiVF
         5sEjB+3nyCM1fm+PVkel2N9WMQ1H6UUbUkJRBShPBBqMz6grOk9HAJ8j2eQWMS5yKZ8q
         uRHS1gfDlJbBJRc7Aaf2cw3D5sMyuJ7RwjvKeI5j+wGy9zmqzh7lr8TJ22WuHdDyM7DN
         pPGo1kty59NuEAfNnoWz0YCFlkEhscHpWxV75W2bIQ6u7+8hAVEFRVvhU6Gq1G7/fTs/
         GbcEOSc3pg/ETLzCeshx+S74nMTt1CM5QvN+5nmSIfoudYcSTdbUaBQRvoRdbD27uKMW
         lIwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of nayna@linux.vnet.ibm.com) smtp.mailfrom=nayna@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of nayna@linux.vnet.ibm.com) smtp.mailfrom=nayna@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v4 2/4] tpm: migrate tpm2_probe() to use struct tpm_buf
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20180326121406.14548-1-jarkko.sakkinen@linux.intel.com>
 <20180326121406.14548-3-jarkko.sakkinen@linux.intel.com>
From: Nayna Jain <nayna@linux.vnet.ibm.com>
Date: Fri, 18 May 2018 12:01:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180326121406.14548-3-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18051806-0024-0000-0000-0000186F066F
X-IBM-SpamModules-Scores: 
X-IBM-SpamModules-Versions: BY=3.00009044; HX=3.00000241; KW=3.00000007;
 PH=3.00000004; SC=3.00000261; SDB=6.01033963; UDB=6.00528730; IPR=6.00813092;
 MB=3.00021176; MTD=3.00000008; XFM=3.00000015; UTC=2018-05-18 06:33:03
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18051806-0025-0000-0000-000050098BE4
Message-Id: <8c7f20fd-4b4f-0f25-35a4-eb1a615f1615@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=9 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805180072
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596002378220804070?=
X-GMAIL-MSGID: =?utf-8?q?1600782531790726115?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/26/2018 05:44 PM, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_probe() to use it.
>
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> Acked-by: Jay Freyensee <why2jjj.linux@gmail.com>

Reviewed-by: Nayna Jain<nayna@linux.vnet.ibm.com>
Tested-by: Nayna Jain<nayna@linux.vnet.ibm.com>


Thanks & Regards,
     - Nayna

> ---
>   drivers/char/tpm/tpm2-cmd.c | 37 +++++++++++++++++++++----------------
>   1 file changed, 21 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 7665661d9230..7bffd0fd1dca 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -844,30 +844,35 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>
>   /**
>    * tpm2_probe() - probe TPM 2.0
> - * @chip: TPM chip to use
> + * @chip: a TPM chip to probe
>    *
> - * Return: < 0 error and 0 on success.
> + * Return: 0 on success,
> + *         -errno otherwise
>    *
> - * Send idempotent TPM 2.0 command and see whether TPM 2.0 chip replied based on
> - * the reply tag.
> + * Send an idempotent TPM 2.0 command and see whether there is TPM2 chip in the
> + * other end based on the response tag. The flag TPM_CHIP_FLAG_TPM2 is set if
> + * this is the case.
>    */
>   int tpm2_probe(struct tpm_chip *chip)
>   {
> -	struct tpm2_cmd cmd;
> +	struct tpm_output_header *out;
> +	struct tpm_buf buf;
>   	int rc;
>
> -	cmd.header.in = tpm2_get_tpm_pt_header;
> -	cmd.params.get_tpm_pt_in.cap_id = cpu_to_be32(TPM2_CAP_TPM_PROPERTIES);
> -	cmd.params.get_tpm_pt_in.property_id = cpu_to_be32(0x100);
> -	cmd.params.get_tpm_pt_in.property_cnt = cpu_to_be32(1);
> -
> -	rc = tpm_transmit_cmd(chip, NULL, &cmd, sizeof(cmd), 0, 0, NULL);
> -	if (rc <  0)
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_CAPABILITY);
> +	if (rc)
>   		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> -		chip->flags |= TPM_CHIP_FLAG_TPM2;
> -
> +	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> +	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
> +	tpm_buf_append_u32(&buf, 1);
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	/* We ignore TPM return codes on purpose. */
> +	if (rc >=  0) {
> +		out = (struct tpm_output_header *)buf.data;
> +		if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
> +			chip->flags |= TPM_CHIP_FLAG_TPM2;
> +	}
> +	tpm_buf_destroy(&buf);
>   	return 0;
>   }
>   EXPORT_SYMBOL_GPL(tpm2_probe);
