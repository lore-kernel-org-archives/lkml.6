Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELtoW4MCqIRui+yY72YU3B1y6R/rx8YHWYwbP0yYw3YS+YgWYaMJ4noPwkHzSmZmkoSwINnT
ARC-Seal: i=1; a=rsa-sha256; t=1520290352; cv=none;
        d=google.com; s=arc-20160816;
        b=guGYeJrmI3aQuSxx1q4ILIiNU6H/I4ZOJrkpJ2RSou6S536yYDQirAt+EZYEhJzDJX
         qC5pDleivABUPY0unccCHhBTlK6w1MydOKShzJ5lxv+fkvZrn2XbZ6fzcN/CQRpqCnG0
         A+eHyk9cxMB5Aeu1Q3xgD7Btzf1LMeCehBSCJ/OK8ZVt3V1/lnmynEL5ZYnumE5J444K
         +89p/FV24zi3iK37oHdlsAGwuSo2V3NdAyiRvINmpWG2RohntmTRF46wDfacmNhDtabj
         tsVAtf7Kx5i7RToPpEw3xqLejzxdailssqMvGU7KlHAoZ/mR1XcnDRyGbzrdmn57dc1V
         xL7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=vc3pebkT6T8A/bPWx0CEgJL+LRisJw8OgMVTwMgCQtY=;
        b=W60S38UTq80o4ips58hyfZoWRoHnS3tkyzILWyiAryCIMvJtcFeRLCyOXGBi6CGWmG
         iKKnI5JHcneEhVkVCetLy7TAjjhSUlmgDV4CO/JRxf2uhSo83bQzjOBt4qlB2zhPGytZ
         yGTutDyw0tcEHrr7V8aEicwwuVtt0yj+PGROp1dAXvKj/iLakt/Em/n8XisOWbhYhJm9
         y+INUESUXOEoMNa2U4k1cG//lEW+Gueh5RWjTbaLkYm3b2z2b4SEMBz55Crg1NBRephH
         LdFoQqNbeQ30oj9iuMP9wf4rAUX6rPoKSenRbaN9TevtwpV5b8UhLtCq7dIN7TSMBV6f
         MstQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 3/5] tpm: migrate tpm2_probe() to use struct tpm_buf
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann
 <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open
 list <linux-kernel@vger.kernel.org>
Date: Mon, 05 Mar 2018 17:52:24 -0500
In-Reply-To: <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
References: <20180305165614.5469-1-jarkko.sakkinen@linux.intel.com>
	 <20180305165614.5469-4-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030522-0020-0000-0000-000003FF0ADF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030522-0021-0000-0000-000042934615
Message-Id: <1520290344.10396.357.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=43 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050260
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676067717266056?=
X-GMAIL-MSGID: =?utf-8?q?1594139976741783924?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Jarrko,

On Mon, 2018-03-05 at 18:56 +0200, Jarkko Sakkinen wrote:
> In order to make struct tpm_buf the first class object for constructing TPM
> commands, migrate tpm2_probe() to use it.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

With this patch, the Pi doesn't find the TPM.  I'm seeing the
following line in dmesg.

[    1.087414] tpm_tis_spi: probe of spi0.0 failed with error 256

Mimi

> ---
>  drivers/char/tpm/tpm2-cmd.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index abe6ef4a7a0b..890d83c5c78b 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -851,22 +851,25 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>   */
>  int tpm2_probe(struct tpm_chip *chip)
>  {
> -	struct tpm2_cmd cmd;
> +	struct tpm_output_header *out;
> +	struct tpm_buf buf;
>  	int rc;
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
>  		return rc;
> -
> -	if (be16_to_cpu(cmd.header.out.tag) == TPM2_ST_NO_SESSIONS)
> +	tpm_buf_append_u32(&buf, TPM2_CAP_TPM_PROPERTIES);
> +	tpm_buf_append_u32(&buf, TPM_PT_TOTAL_COMMANDS);
> +	tpm_buf_append_u32(&buf, 1);
> +	rc = tpm_transmit_cmd(chip, NULL, buf.data, PAGE_SIZE, 0, 0, NULL);
> +	if (rc <  0)
> +		goto out;
> +	out = (struct tpm_output_header *)buf.data;
> +	if (be16_to_cpu(out->tag) == TPM2_ST_NO_SESSIONS)
>  		chip->flags |= TPM_CHIP_FLAG_TPM2;
> -
> -	return 0;
> +out:
> +	tpm_buf_destroy(&buf);
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(tpm2_probe);
> 
