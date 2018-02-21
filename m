Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225MZmq6UUSKwN3bn9q9UVUoqQqvY53Ifi0qg2DDV4cCsBwyRSRmz1LOIJb0pyu8xfCTHLuM
ARC-Seal: i=1; a=rsa-sha256; t=1519217658; cv=none;
        d=google.com; s=arc-20160816;
        b=Ayy0rNT4S/oP/Kcn4bPB+xOqWR1eXaRXWTI1CbXP4h5vCJ3Opxj6BagON2jXGQNtsn
         rHIMy23fNL1DSsw+lE6MEoNw0FcKnOilo+SPVi7xrSfodHGZ78DOs0ksiHJMUazaehRX
         F+c9srBmzf2Ftf3oTCpf58Iizzyueb/f0sg3IF67veXKYKQytl6VIutICb0D3FXszTFc
         iaC+vR5dpGynasshnxdrPOcvn1Kv8SrhA4nlQoKqytLLNJhxrhaFp/RpAbGHKutn6TPs
         ppbtHq9SgxGWqbpz5UoJIunMYT+WP7dpbNkNqsZYOAScyVXukh20mY4COlMmoEkTEHTR
         ICuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=fqJAVt8xUbQ57zGQm/Uox/3XKBBrxRhCwFAbyzeyAj4=;
        b=CkTZGcBFhIOOJN3Q2ClRSek6ESo3ZFuKw2oOQFJglLpDFtaA/ADaiFj3nD0CyUQ64W
         lOmgfYBdSb8UOah+/vegZDp+FOzPWDeXh6El5JcVXl9QFq//Cj7OFamiPvORMuu1tzm4
         8vSFLbE5wqYEWeCUFdKSNNgZWA+VGfGSI0nH75kxl1c9neUrXqcutakMm/k3SCM3c+xS
         92R/XqyK1YokfSzYnPA88Vji6gxPiHey+7RAtyDcEzdQVOJHbHr6Ag3/4oE3A4TVpkAw
         YLhkUjbVW46nHq8VfR6fVyWoKfZk7YstaWfkYe/qy8JIQhPTixYmCcBoMspccb0Cn55I
         Q6tw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Steffen Weber <steffen.weber@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH 4.9 01/77] scsi: smartpqi: allow static build ("built-in")
Date: Wed, 21 Feb 2018 13:48:10 +0100
Message-Id: <20180221124432.230219713@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124432.172390020@linuxfoundation.org>
References: <20180221124432.172390020@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015175879199840?=
X-GMAIL-MSGID: =?utf-8?q?1593015175879199840?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steffen Weber <steffen.weber@gmail.com>

commit dc2db1dc5fb9ab3a43b305c2720fee5278dbee2a upstream.

If CONFIG_SCSI_SMARTPQI=y then don't build this driver as a module.

Signed-off-by: Steffen Weber <steffen.weber@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/scsi/smartpqi/Makefile |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/smartpqi/Makefile
+++ b/drivers/scsi/smartpqi/Makefile
@@ -1,3 +1,3 @@
 ccflags-y += -I.
-obj-m		+= smartpqi.o
+obj-$(CONFIG_SCSI_SMARTPQI) += smartpqi.o
 smartpqi-objs := smartpqi_init.o smartpqi_sis.o smartpqi_sas_transport.o
