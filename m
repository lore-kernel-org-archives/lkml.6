Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x225G6CdrtpIDERQNz5O55l0dWUNV6l29yB7qYLnoZjZaemjNjI+ti3dVDQbw3lGkaRyKpXEe
ARC-Seal: i=1; a=rsa-sha256; t=1519218421; cv=none;
        d=google.com; s=arc-20160816;
        b=hpt5tJkgj9Jsh8Ts1wkMo05dOdAaMyFmcpF6G8STejB8Njc7mR7kpfkm70m1GM2ohC
         0TFCAa11/+a5HS5CBTkccOCJoIzJ9p3iPG9nftQsfUMaMGRiKQ2I56AYWjXu7/4sr79Z
         Be6Ts0CVRDuij40GQXW0tpbdhuAs7z44c6DSOoB37/9kV6yi9h+gYD1ETuoy3ucXUr7M
         SvdLDUtlaaAp9augx8+RaOKBvmXsNFBWNddhN5s90fcwbr5V5YUaHqNwjLL8v7pmyx1i
         vKUh8WeyiU3KeKEexY8r5aXGJeo6mAR/SvAq9E0OVes70n5UohchVNozdfew6g657dO9
         pgVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=AzR5WLUOCBywcfzmVXs6hS/AfYxDIJRDkXXPiHS13WU=;
        b=ZRZTZo1WPyT8LIbZPKCPIGwVQMUpyqSI12U2sVhi+AraLNn6k6Hl/5yRLWXur85H9h
         IuSY/Q2F4T+7NylnraCk/MPSXS0oEdB8FBN8FGxUjYWRGbaGHMAvG4i1Zj+Nx46JMYxu
         UtcGNOPafb0ZeqCD8S3YdkiK1/hIsuPPD84qOgvF5P+BIIEWb3du/wyliiADVsUh/bnm
         pqUW/U2XOtwKvL5b8dNn0baN5LpL9koXDt22Lywd++gwuf4frm52NQTry0kZiluqrdDu
         GteSxLf9yGSP/LQjL61WibLOoByIK2APWnpWPQ6w1uR0wSFvse58X5y/1M/YjHpqc16o
         SqbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Olof Johansson <olof@lixom.net>
Subject: [PATCH 4.15 034/163] arm: spear13xx: Fix spics gpio controllers warning
Date: Wed, 21 Feb 2018 13:47:43 +0100
Message-Id: <20180221124532.161662256@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124529.931834518@linuxfoundation.org>
References: <20180221124529.931834518@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014666669772873?=
X-GMAIL-MSGID: =?utf-8?q?1593015976181303192?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Viresh Kumar <viresh.kumar@linaro.org>

commit f8975cb1b8a36d0839b6365235778dd9df1d04ca upstream.

This fixes the following warning by also sending the flags argument for
gpio controllers:

Property 'cs-gpios', cell 6 is not a phandle reference in
/ahb/apb/spi@e0100000

Fixes: 8113ba917dfa ("ARM: SPEAr: DT: Update device nodes")
Cc: stable@vger.kernel.org # v3.8+
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm/boot/dts/spear1310-evb.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -349,7 +349,7 @@
 			spi0: spi@e0100000 {
 				status = "okay";
 				num-cs = <3>;
-				cs-gpios = <&gpio1 7 0>, <&spics 0>, <&spics 1>;
+				cs-gpios = <&gpio1 7 0>, <&spics 0 0>, <&spics 1 0>;
 
 				stmpe610@0 {
 					compatible = "st,stmpe610";
