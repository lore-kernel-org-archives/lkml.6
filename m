Return-Path: <festevam@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523209204; cv=none;
        d=google.com; s=arc-20160816;
        b=fXJ8WRW9rIUR+3fQ8EdXDP/pr44siKkNc+nz55bXoEcmsor884eGTcYFsCywDHcR+a
         TaJHjV+i/lRfWJU0I8VZpxMgftf+7dBZktna36Z+iOyTOMabOOfyAZPKDAlq/OgeHqkc
         X2KVWnUUT0wpUcagHUxC49hYaaF+4IiQJES4acDFpLklaFZHxrUk9kJdKGMy6qjsjuBr
         OrK4u7rMtcge6h3x+qgTEQ0T7hWRI3QaqtBUSDMIriAltA9szfUqzYuov21D01VlOc/7
         pXDteRTapNpaSHAO4mwbB9Zto8WbF45yNz3XT7hKTq+0KR3fynJ93B9W8SUDaBYc+lUm
         zCAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Nt+e0Z2mvrCXEGxtM2SgcNzzmCF9+lIGqja1/L9SwLE=;
        b=Kxj5BA8/5WwQ3kLEFxepa/BSjXcGjJBWhJhQ0oTKyObgci0bh3zgqrOz377xslBsE3
         9d23cWCDNaJdRmpUzVYA3sL5RCIenv20co42TOEqlVsTkrDHiSQDmRpCodU+VDg38Y/K
         5Wpuy9uzgWyvUXcksUgSLceM9ieB0fpH8d3AH1y8jWfz/gJ1FfxTmI7tBIllj6ZKo4h8
         CkzXHsbEbB3NsmsQ7xGu5wzZXeGuzxeb0PnVDEIRd9ca4IrZaPmS8Xuo4tdmGgw++bai
         DrTjrBhILwTurgxdfsK13Gpt5O4LRljz1DEoyr5964J6nU2KE3SUq1oH8UrPgK1LPmiI
         jcww==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sgyTT+w1;
       spf=pass (google.com: domain of festevam@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=festevam@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=sgyTT+w1;
       spf=pass (google.com: domain of festevam@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=festevam@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4/I0FTZUVKIZqS/j2PvEBfa3vy1Ubx/UkA9JvbnRyRCzfrutUI/QGHsTcBZNxanxGeRIU86Yt2RAJiXPqihkag=
MIME-Version: 1.0
In-Reply-To: <20180403153635.8228-2-peda@axentia.se>
References: <20180403153635.8228-1-peda@axentia.se> <20180403153635.8228-2-peda@axentia.se>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 8 Apr 2018 14:40:03 -0300
Message-ID: <CAOMZO5CWjJ1WMnrFnqFC+324AqghFgCzSGasgwVkAw_YZHJBzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: afe: add current-sense-cuicuit
 and voltage-divider
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, "David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Walleij <linus.walleij@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Michael Hennerich <michael.hennerich@analog.com>,
	Phil Reid <preid@electromag.com.au>, linux-iio@vger.kernel.org,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739881382169628?=
X-GMAIL-MSGID: =?utf-8?q?1597200614279156727?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 3, 2018 at 12:36 PM, Peter Rosin <peda@axentia.se> wrote:

> diff --git a/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> new file mode 100644
> index 000000000000..0bc7d89387c0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/afe/current-sense-circuit.txt
> @@ -0,0 +1,45 @@
> +Current Sense Curcuit

s/Curcuit/Circuit

> +=====================
> +
> +When an io-channel measures the voltage over a current sense resistor,
> +the interesting mesaurement is often the current through the resistor,
> +not the voltage over it. This binding describes such a current sense
> +curcuit.

s/curcuit/circuit
