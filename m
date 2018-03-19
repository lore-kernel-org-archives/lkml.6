Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELtS7Lf7Z0jVIurxcj7rr086PjxoAdMm/wjxrHV2FwUBy+VmrtTbe3bSVCNT08KdfOW7jdCz
ARC-Seal: i=1; a=rsa-sha256; t=1521483494; cv=none;
        d=google.com; s=arc-20160816;
        b=Gv3zqSP2wFMWYP+vDaoe+SonfhKYOhtppbAvWycJw6+ZdChCDh/jonQfyBmUQwvQss
         PDQr16Sa6Kyu1gtygu23rB08itmYSlMMPOyEXVotT5tN/zdXU5YJ5uZUxfzjBeBytLwI
         z/GFZRtym6Quoe5rcH5I/gpuS2bidn9fUHGK8zfrh2ESX23OGYDpjralExyejUeGhDoG
         5UvMl6bZUUcqg28ytSTMPj+chK3JV4XL9Pr5AwSHBGJW19oTyoWGMz65WVuwTIEOU72p
         gabz3plaZB/a3y+UWAd+VyktNf4dTSyTqzK2DfJ9Gji43DLOOg5cO8E71BJu/MNcHQQJ
         El1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=xpLxn+Dl4ZscSYrqusJswGt3gaSrB2uUbgqJr/YDLdA=;
        b=XYnaE2MLQgWeg00x3ZMtriNMJnyghYcfvTNPESrDJ+aJqFdVepsys8ldbOMBVJSmU2
         RkVCWUsX4FnrFqOnvzgw9JDTHDEgQsTpiuCL2DNFM75xYQptpzv6LIawwRkkKwP9XO7p
         TL+wfc2Ru7KzuN7BwMUmyYZkdDVO1SAb+0vvJtXmt8Vil1QJ4F0sTvMCvFVC69SEtpwR
         0e5xwINjcNf9irm6ErgmtbwjxLEuuEKswNhGau/czRhHK1uE1PKnZMzjCxSPjrCD5duA
         ChKAidg4sEEQLqw85atacBqTHQ+nKJEzfyeizRotcr6eVICdn9TvdpdbpekP6FEuoFmU
         p93g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 010/241] ARM: dts: r8a7793: Remove unit-address and reg from integrated cache
Date: Mon, 19 Mar 2018 19:04:35 +0100
Message-Id: <20180319180751.604737699@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391076745780101?=
X-GMAIL-MSGID: =?utf-8?q?1595391076745780101?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>


[ Upstream commit beffa8872a3680ef804eb0320ec77037170f4686 ]

The Cortex-A15 cache controller is an integrated controller, and thus
the device node representing it should not have a unit-addresses or reg
property.

Fixes: ad53f5f00b095a0d ("ARM: dts: r8a7793: Fix W=1 dtc warnings")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/boot/dts/r8a7793.dtsi |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/arch/arm/boot/dts/r8a7793.dtsi
+++ b/arch/arm/boot/dts/r8a7793.dtsi
@@ -65,9 +65,8 @@
 			power-domains = <&sysc R8A7793_PD_CA15_CPU1>;
 		};
 
-		L2_CA15: cache-controller@0 {
+		L2_CA15: cache-controller-0 {
 			compatible = "cache";
-			reg = <0>;
 			power-domains = <&sysc R8A7793_PD_CA15_SCU>;
 			cache-unified;
 			cache-level = <2>;
