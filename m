Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-610692-1526294522-2-16879398603382482182
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526294521; b=EMwO8z4+2Zvxb2BJ9z8K6Ham0lD+49u96Ytfbz1og7q5qe/ToN
    92I06jTY9ntUvG496+HERnEmMxjgSCQp8+Jy77RevAg4JlwRdHwo6QMOfZkFuo7l
    /IotU7H/7CKktsuNP/kzOUoDxLxOIFfgxlR06DuH1GJoWgZaSEWG0GcYXYfgvnGY
    zexx+C5qsSU/BJ4GhXZCBQRumg5TO2JVwI1EINYJwgiGwNzYFQ1ZIQSYgmjY5L3E
    fV/7YYzrQ7VXrG8qZQMVL1PFbTcMbDUYDTlzLb77KQ1eNHP+vrqEDEnYnbuHtpRp
    tyfLcM76xbzAzhzWlFa9ea6uLaZ70qkMkMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526294521; bh=S06ogZ8c1gWVAH5tqPzm3kJsbPE1JO
    7alLS732Sulhc=; b=CXKfT8wFrtLG1DWZm7sQVpz+GTcLZoaTlXnvLPSNmUDRBA
    rPQQ04ZIsoLQVUK/AxmeRey5QCLqSb5B49uFgxkYwkXNeKdOG6aRYBtZRq8K9DrF
    TeD2bIpUEs72w7DOYkMK0p3XCljC0/DP7BfWsK7iiL1SjRgcOgRWcjflLK6Yp11r
    /y4yFTCP0Qex8g1KGsXWMRZiQVUkDuZrIXFmPKKTFP5OpfivWN9+vSJ4xn2Fapnn
    2Zd4AhDa6CFYE9mwAejdGDqvQ82eNFgS8cd+cUcflcGVwzwxAToYnvuuDqeFa7ln
    8lUfuUW6sALTpdaDwoQO6g9udR0ur7NhfzOZ64TA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linux.intel.com header.result=pass
    header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linux.intel.com header.result=pass
      header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPvBUeKAHQfoEQxfJpkaMofoe3rc94iXRdDSQ1Yn6ROGG7hPeS84P7Mcfx6poQCI1MJhKZ71T/ae8Ipykm+ZRKaXOBwmp+FyVJFVYt6kHErMLCfKovTJ
    vZawsno+ensfGBnwTZq+oAOlXkzHWBy6HO1GSOibWdEHy3FFyAG+lzh63Iyy652yKoO9/Bw6LPKR+MLQkzOpZUk7ZV100/tRidAIPtmKq9c0OqADiqcjCjrL
    llhwcuoQmgSPVFd+jkHF+A==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=gyn_r4YW0nXI3FXChswA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752046AbeENKmA (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 06:42:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:50656 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751954AbeENKl7 (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Mon, 14 May 2018 06:41:59 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,399,1520924400";
   d="scan'208";a="54121083"
Date: Mon, 14 May 2018 13:41:53 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: Nayna Jain <nayna@linux.vnet.ibm.com>
Cc: linux-integrity@vger.kernel.org, zohar@linux.vnet.ibm.com,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, peterhuewe@gmx.de,
        tpmdd@selhorst.net, jgunthorpe@obsidianresearch.com
Subject: Re: [PATCH v2] tpm: check selftest status before retrying full
 selftest
Message-ID: <20180514104153.GB8228@linux.intel.com>
References: <20180507153941.4952-1-nayna@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507153941.4952-1-nayna@linux.vnet.ibm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 07, 2018 at 09:09:41PM +0530, Nayna Jain wrote:
> As per the TCG Specification[1][2], RC_COMMAND_CODE indicates that the TPM
> command is not implemented or not supported. When RC_COMMAND_CODE is
> returned in response to the partial selftest, this is not the case. TPM 2.0
> supports TPM2_GetTestResult[3], which can be used to check the selftest
> status before sending the full selftest command.
> 
> This patch implements the tpm2_get_selftest_result function to check the
> selftest status when partial selftest returns RC_COMMAND_CODE.

Cosmetic: parentheses when referring to functions.

> This change results in finishing of the selftest much earlier compared to
> the existing case where full selftest is immediately sent to retry. The
> Pi's dmesg shows: the TPM selftest completed at 1.243864 secs compared
> with the previous timestamp of 1.939667 secs.
> 
> [1] As per the TCG Specification, Trusted Platform Module Library,
> Part 2 - Structures, Section 6.6.3 and Section 4.18:
> 
> "RC_COMMAND_CODE indicates the response code that is returned if the TPM is
> unmarshalling a value that it expects to be a TPM_CC and the input value is
> not in the table."
> 
> [2] As per the TCG Specification, Trusted Platform Module Library,
> Part 2 - Commands, Section 5.2:
> 
> "The TPM shall successfully unmarshal a TPM_CC and verify that the command
> is implemented (TPM_RC_COMMAND_CODE)."
> 
> [3] As per the TCG Specification, Trusted Platform Module Library,
> Part 2 - Commands, Section 10.4:
> 
> "This command(TPM2_GetTestResult) returns manufacturer-specific information
> regarding the results of a self-test and an indication of the test status."
> 
> Signed-off-by: Nayna Jain <nayna@linux.vnet.ibm.com>
> Tested-by: Mimi Zohar <zohar@linux.vnet.ibm.com> (on Pi with TPM 2.0)
> ---
> 
> Changelog v2:
> * changed the subject and updated patch description
> * removed the logs
> 
>  drivers/char/tpm/tpm.h      |  2 ++
>  drivers/char/tpm/tpm2-cmd.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
> index af3bb87d3ea1..1de4240b52c4 100644
> --- a/drivers/char/tpm/tpm.h
> +++ b/drivers/char/tpm/tpm.h
> @@ -114,6 +114,7 @@ enum tpm2_return_codes {
>  	TPM2_RC_FAILURE		= 0x0101,
>  	TPM2_RC_DISABLED	= 0x0120,
>  	TPM2_RC_COMMAND_CODE    = 0x0143,
> +	TPM2_RC_NEEDS_TEST      = 0x0153,
>  	TPM2_RC_TESTING		= 0x090A, /* RC_WARN */
>  	TPM2_RC_REFERENCE_H0	= 0x0910,
>  	TPM2_RC_RETRY		= 0x0922,
> @@ -144,6 +145,7 @@ enum tpm2_command_codes {
>  	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
>  	TPM2_CC_GET_CAPABILITY	= 0x017A,
>  	TPM2_CC_GET_RANDOM	= 0x017B,
> +	TPM2_CC_GET_TEST_RESULT = 0x017C,
>  	TPM2_CC_PCR_READ	= 0x017E,
>  	TPM2_CC_PCR_EXTEND	= 0x0182,
>  	TPM2_CC_LAST		= 0x018F,
> diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
> index 96c77c8e7f40..4abba0ebe25b 100644
> --- a/drivers/char/tpm/tpm2-cmd.c
> +++ b/drivers/char/tpm/tpm2-cmd.c
> @@ -825,6 +825,50 @@ unsigned long tpm2_calc_ordinal_duration(struct tpm_chip *chip, u32 ordinal)
>  EXPORT_SYMBOL_GPL(tpm2_calc_ordinal_duration);
>  
>  /**
> + * tpm2_get_selftest_result() - get the status of self tests
> + *

There should not be an empty line here.

> + * @chip: TPM chip to use
> + *
> + * Return: If error return rc, else return the result of the self tests.
> + * TPM_RC_NEEDS_TESTING: No self tests are done. Needs testing.
> + * TPM_RC_TESTING: Self tests are in progress.
> + * TPM_RC_SUCCESS: Self tests completed successfully.
> + * TPM_RC_FAILURE: Self tests completed failure.
> + *
> + * This function can be used to check the status of self tests on the TPM.
> + */

Description should 

Better to just have:

Return:
  TPM return code,
  -errno otherwise
 
There is a lot of variance in return values but this is the format where
I would like the code base to dilate to. Describing TPM return codes
one by one is not very maintainable in the long run.

See:
https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt


> +static int tpm2_get_selftest_result(struct tpm_chip *chip)
> +{
> +	struct tpm_buf buf;
> +	int rc;
> +	int test_result;
> +	uint16_t data_size;
> +	int len;
> +	const struct tpm_output_header *header;
> +
> +	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_GET_TEST_RESULT);
> +	if (rc)
> +		return rc;
> +
> +	len = tpm_transmit(chip, NULL, buf.data, PAGE_SIZE, 0);
> +	if (len <  0)
> +		return len;
> +
> +	header = (struct tpm_output_header *)buf.data;
> +
> +	rc = be32_to_cpu(header->return_code);
> +	if (rc)
> +		return rc;
> +
> +	data_size = be16_to_cpup((__be16 *)&buf.data[TPM_HEADER_SIZE]);
> +
> +	test_result = be32_to_cpup((__be32 *)
> +			(&buf.data[TPM_HEADER_SIZE + 2 + data_size]));
> +
> +	return test_result;
> +}
> +
> +/**
>   * tpm2_do_selftest() - ensure that all self tests have passed
>   *
>   * @chip: TPM chip to use
> @@ -853,6 +897,10 @@ static int tpm2_do_selftest(struct tpm_chip *chip)
>  				      "attempting the self test");
>  		tpm_buf_destroy(&buf);
>  
> +		/* Check the selftest status */

What is the purpose of this comment eg what does it describe that isn't
obvious?

> +		if (rc == TPM2_RC_COMMAND_CODE)
> +			rc = tpm2_get_selftest_result(chip);
> +
>  		if (rc == TPM2_RC_TESTING)
>  			rc = TPM2_RC_SUCCESS;
>  		if (rc == TPM2_RC_INITIALIZE || rc == TPM2_RC_SUCCESS)
> -- 
> 2.13.6
> 
