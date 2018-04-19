Return-Path: <djkurtz@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524097637; cv=none;
        d=google.com; s=arc-20160816;
        b=elv8oCdXezW9Ztmscusi4/tBcbSdn+0YJb2ew9zL5JBKxFr0l4sSh08xTua6HIrFEU
         CVHWa1aPemnN9udno+bWCJnHes5cX/pjPKuWL8CORFWy+v/3ee8H6VBzN6HuRyP1R/IN
         b9eFWXBKdDTqYxgis0RMQm+SrOtDNtzeeQZlCN127VzWF1dImONCoUe8AU/IHE6OSZ8t
         5glyzWyiGJR5gVmL8wKGsY5N0KgBVsn69FHYimVyG0LxO26j9I1gHMDvR3SVWRGz5jcm
         dD32bXRQAl9V3PEbAR0GlJD9ih7T4RQq+ouMAnRWkfqL33m4xAKltcKfjhhC3GC3MRcM
         3zTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eDI/2hm8fsAQVidfCdjkNb0wLfG1sYQcVG7NO5mB7tE=;
        b=mvyLabRekAcq9URxGtCODTQDchoPhNtXn1AUznUG/oWriaPJLLV6mUGeyEjcAk3Jdw
         2UGbLVs03vn8dmLeY0DKBf5PzrhGSUJG4n1eu7AD0kYNXwrKE1T1oUbSla+TCg7B1pgx
         3z4JMf6tWdS/IS4Bn7iaDMPECkZWY1JoVce0fdoFXQqo6eLssg2Bn5OCcT7t1RaCiJjf
         vtckzUe9u2CjQ5tmyAOoXz4PGKdBy5Tf2+SI4SHXROyi6mNyX9nIValiyoA+Oybq0iag
         zmaGnDT78+GugQLiufFcruC2xzCUigvcaYocO2fR6luG3Kk45NWxQx8sFyzrZ+VHgx/L
         qTJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=QkjYtyAk;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@chromium.org header.s=google header.b=QkjYtyAk;
       spf=pass (google.com: domain of djkurtz@google.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=djkurtz@google.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
X-Google-Smtp-Source: AIpwx49BRPrM/G5+ckJ+UF1dlCUokz8JdratKYYvPHWHpdXZYRRMfRe3GDuHr89dD/E8NKnoDkPAVEZvllgYQcoMcfQ=
MIME-Version: 1.0
References: <1524049494-19526-1-git-send-email-Vijendar.Mukunda@amd.com> <1524049494-19526-3-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524049494-19526-3-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Thu, 19 Apr 2018 00:27:05 +0000
Message-ID: <CAGS+omBzuC75-pbROzwhQ9WqPQpKywZKEYMYGhdjvDNdZu2j=Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] ASoC: amd: dma driver changes for BT I2S instance
To: Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, perex@perex.cz,
	tiwai@suse.com, alexander.deucher@amd.com,
	Akshu Agrawal <akshu.agrawal@amd.com>, jclinton@chromium.org,
	Guenter Roeck <linux@roeck-us.net>, kuninori.morimoto.gx@renesas.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598081599449157832?=
X-GMAIL-MSGID: =?utf-8?q?1598132204141927235?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Vijendar,

On Wed, Apr 18, 2018 at 5:02 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> With in ACP, There are three I2S controllers can be
> configured/enabled ( I2S SP, I2S MICSP, I2S BT).
> Default enabled I2S controller instance is I2S SP.
> This patch provides required changes to support I2S BT
> controller Instance.

I like the direction this patch is taking, but I think it would be easier
to review if you could split it into 2 parts:
  (1) the cleanup of the existing driver to use a simplified flow for
playback vs capture paths.
  (2) adding the BT I2S channel.


Thanks,
-Dan
