Return-Path: <bich.hemon@st.com>
X-Google-Smtp-Source: AG47ELtmuI6FO1tAVLqHWYeIqpvnEDjMOYTrItgzMpK4SZby/wfCAKqcvFYQbhbOZZ8BP32GxLYx
ARC-Seal: i=1; a=rsa-sha256; t=1521103493; cv=none;
        d=google.com; s=arc-20160816;
        b=VwFhn6+fuqTEWAAQInNUHOzF8TdTJof42ipxz6cXQedlhGu5GJvWosgmCvZqhz1/hk
         so8YdFfUfVONnylZwG5gkuPHLbk4qShirpZDatLj0iQRR6g0xfFMUWAmhiQLT/ae8sYH
         IavuUZH/zL+oL72LCnbp5+BFhjN+jWAtfK2h6NIZujvFSqIEOc8ocn9b76nqlv+prgLj
         0YBOZUrpwK1VjmVDNP9BMSO42n2ZSo0zc9sMmOnDb+I4ERc0k8FwlnGlNnCUsvH+80Zk
         1oQvyheRCXi5MFBKt4VIft7X0iyPIJLiBVGjo6PN1jaXiLjgzCp8s8Iy2UInkRdQHqrQ
         /cPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :cc:to:from:arc-authentication-results;
        bh=eh+IRhRc1CqJqWq9KdZbS5Fz56QZ094fKFD0WTf0XGA=;
        b=g59hmNxEQXn6nP1+7a7+cEHcAf0xrK0ePnBsIpxyy8nxAoCwMM3IxjeOoKoqvetkDA
         Gyl4/lBqtbZQokeY7kaN9ubeVcfNi7sVBWj7aD0XjSeDPvzVoiunbUQ8dy0D8l31V1u3
         vSK5eWW6vCTFRLeVBAPp5SwwS8Xx5CFxyMPCajIQXhVGpWfdkkkwB/SN6XpyJCAYvtKW
         //fl7rpFgxCloUyKAtlHjFiDZbs/sxBjtkn1L/2AoBeF/T8JJYQGjeC45wSwwMbzgxAS
         DqS4WjbPAsvGaARMeSqKA49JgGjrkwMKKuPaMW21XisqDURFE0mKXaouwWijQjB31K3w
         yIVQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bich.hemon@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=bich.hemon@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bich.hemon@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=bich.hemon@st.com
From: Bich HEMON <bich.hemon@st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring
	<robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "Jiri Slaby" <jslaby@suse.com>,
        "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Bich HEMON <bich.hemon@st.com>
Subject: [PATCH] serial: stm32: fix initialization of RS485 mode
Thread-Topic: [PATCH] serial: stm32: fix initialization of RS485 mode
Thread-Index: AQHTvDnfm3zhfM7hv06tT6Pb4c9WQw==
Date: Thu, 15 Mar 2018 08:44:46 +0000
Message-ID: <1521103480-6940-1-git-send-email-bich.hemon@st.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.75.127.47]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_04:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594992617354613977?=
X-GMAIL-MSGID: =?utf-8?q?1594992617354613977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Configure RS485 mode during port initialization.

Fixes: 1bcda09d2910 ("serial: stm32: add support for RS485 hardware control mode")
Signed-off-by: Bich Hemon <bich.hemon@st.com>
Acked-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/tty/serial/stm32-usart.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-us=
art.c
index 345fbf3..e8d7a7b 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -809,6 +809,10 @@ static int stm32_init_port(struct stm32_port *stm32por=
t,
 	port->ops	=3D &stm32_uart_ops;
 	port->dev	=3D &pdev->dev;
 	port->irq	=3D platform_get_irq(pdev, 0);
+	port->rs485_config =3D stm32_config_rs485;
+
+	stm32_init_rs485(port, pdev);
+
 	stm32port->wakeirq =3D platform_get_irq(pdev, 1);
 	stm32port->fifoen =3D stm32port->info->cfg.has_fifo;
=20
--=20
1.9.1
