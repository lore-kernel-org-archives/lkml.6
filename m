Return-Path: <zohar@linux.vnet.ibm.com>
X-Google-Smtp-Source: AB8JxZrWukAeMFm1Z3jp7LVn6l+h85SKP31ihsiVTT0SLYBTrxHtnbupzodvNXeZsk8onwROLJr6
ARC-Seal: i=1; a=rsa-sha256; t=1525185392; cv=none;
        d=google.com; s=arc-20160816;
        b=ElrwZsyCYyVi29nMtY26ZpOQZErigiU3/3gxAvxQD7FDqnRgf31EblW+qA8gIaCUoZ
         SfB9SaVytRYa7O3wtBjd0Er5cNnBciGaEyUjqrRHjujvGrYHGIjaIfZpLdsGerxz5GNW
         ktPjqxadsSltnGboEuigDy3dK9661+Gq5yx3sCgLFU5RHtMDRFH/jL2PMiJhqrJdCHph
         t+ipyCd0+/qZpu3GnCNBcjfKwfksBD6FUAB2fJEnJyRnnF7hfytyaA42Z7FN7OhsSTSh
         6pJ8XAyCMyshLCmIinJbPAb2nJMrYEgYTuQLkC4VuFTeQTIVBe7CQ8QoK0FQK9eBwn9a
         o9iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:mime-version:references
         :in-reply-to:date:cc:to:from:subject:arc-authentication-results;
        bh=rvYGNe/6Y9r+d3NAAxO7svE/13UTujnGPDH9dRwdRdk=;
        b=Mv3Ju1ZK5jYCBRvYKWPmegue/JbzZ3sr1AStHBtUrEg1oYuftlV0L0xDXgDW+7kUSw
         GAzq1ni/+SugA+qHayqK8kDxLfc1LyidL8dsPqUDvR8/8rdGDtIWt7GqZuuyR9U1NSCk
         opSYS+AIklPJ+wawA3fX5kKqbSVkDl3lj4jN/rl3LKmrxKJMBUWhgQQJm6mqN1+UQjCo
         kcQDooOCQWA3gprliewrRRuHMd+8apr3Hc9EX8kGwGyxT+zu1dmYMbNqoJXDgu7qNHIQ
         UiCny+v4hAwbh4CXftEplhW0WQo45155orQFKdI8TkjVVlsXOmHB5Y2+8aOsoBjNocBl
         NNHA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of zohar@linux.vnet.ibm.com) smtp.mailfrom=zohar@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v5 2/5] efi: Add embedded peripheral firmware support
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Hans de Goede <hdegoede@redhat.com>,
        Ard Biesheuvel
 <ard.biesheuvel@linaro.org>,
        "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin"
 <hpa@zytor.com>
Cc: Peter Jones <pjones@redhat.com>, Dave Olsthoorn <dave@bewaar.me>,
        Will
 Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
        Matt
 Fleming <matt@codeblueprint.co.uk>,
        David Howells <dhowells@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>, dmitry.torokhov@gmail.com,
        mfuzzey@parkeon.com, Kalle Valo <kvalo@codeaurora.org>,
        Arend Van Spriel
 <arend.vanspriel@broadcom.com>,
        Linus Torvalds
 <torvalds@linux-foundation.org>, nbroeking@me.com,
        bjorn.andersson@linaro.org, Torsten Duwe <duwe@suse.de>,
        Kees Cook
 <keescook@chromium.org>, x86@kernel.org,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module
 <linux-security-module@vger.kernel.org>
Date: Tue, 01 May 2018 10:36:14 -0400
In-Reply-To: <20180429093558.5411-3-hdegoede@redhat.com>
References: <20180429093558.5411-1-hdegoede@redhat.com>
	 <20180429093558.5411-3-hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050114-0020-0000-0000-00000417CD54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050114-0021-0000-0000-000042ACE528
Message-Id: <1525185374.5669.49.camel@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-01_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805010146
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599072709046551146?=
X-GMAIL-MSGID: =?utf-8?q?1599272797792613641?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[Cc'ing linux-security]

On Sun, 2018-04-29 at 11:35 +0200, Hans de Goede wrote:
[...]
> diff --git a/drivers/base/firmware_loader/fallback_efi.c b/drivers/base/firmware_loader/fallback_efi.c
> new file mode 100644
> index 000000000000..82ba82f48a79
> --- /dev/null
> +++ b/drivers/base/firmware_loader/fallback_efi.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/efi_embedded_fw.h>
> +#include <linux/property.h>
> +#include <linux/security.h>
> +#include <linux/vmalloc.h>
> +
> +#include "fallback.h"
> +#include "firmware.h"
> +
> +int fw_get_efi_embedded_fw(struct device *dev, struct fw_priv *fw_priv,
> +			   enum fw_opt *opt_flags, int ret)
> +{
> +	enum kernel_read_file_id id = READING_FIRMWARE;

Please define a new kernel_read_file_id for this (eg.
READING_FIRMWARE_EFI_EMBEDDED).

> +	size_t size, max = INT_MAX;
> +	int rc;
> +
> +	if (!dev)
> +		return ret;
> +
> +	if (!device_property_read_bool(dev, "efi-embedded-firmware"))
> +		return ret;

Instead of calling security_kernel_post_read_file(), either in
device_property_read_bool() or here call security_kernel_read_file().

The pre read call is for deciding whether to allow this call
independent of the firmware being loaded, whereas the post security
call is currently being used by IMA-appraisal for verifying a
signature.  There might be other LSMs using the post hook as well.  As
there is no kernel signature associated with this firmware, use the
security pre read_file hook.

thanks,

Mimi

> +
> +	*opt_flags |= FW_OPT_NO_WARN | FW_OPT_NOCACHE | FW_OPT_NOFALLBACK;
> +
> +	/* Already populated data member means we're loading into a buffer */
> +	if (fw_priv->data) {
> +		id = READING_FIRMWARE_PREALLOC_BUFFER;
> +		max = fw_priv->allocated_size;
> +	}
> +
> +	rc = efi_get_embedded_fw(fw_priv->fw_name, &fw_priv->data, &size, max);
> +	if (rc) {
> +		dev_warn(dev, "Firmware %s not in EFI\n", fw_priv->fw_name);
> +		return ret;
> +	}
> +
> +	rc = security_kernel_post_read_file(NULL, fw_priv->data, size, id);
> +	if (rc) {
> +		if (id != READING_FIRMWARE_PREALLOC_BUFFER) {
> +			vfree(fw_priv->data);
> +			fw_priv->data = NULL;
> +		}
> +		return rc;
> +	}
> +
> +	dev_dbg(dev, "using efi-embedded fw %s\n", fw_priv->fw_name);
> +	fw_priv->size = size;
> +	fw_state_done(fw_priv);
> +	return 0;
> +}
