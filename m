Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEBFC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7B2173D
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:01:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A7B2173D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ts.fujitsu.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbeI1OX6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:23:58 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:59366 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726106AbeI1OX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:23:58 -0400
Received: from [85.158.142.101] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 6C/89-28090-4DFDDAB5; Fri, 28 Sep 2018 08:01:24 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleJIrShJLcpLzFFi42Kxs+GYonv5/tp
  ogxe7pS323tK2uLxrDpsDk8fnTXIBjFGsmXlJ+RUJrBkfn7SwFKxSqFi9UKSBcad8FyMXh5DA
  EkaJ/S/vM3cxcgI5ZRK/9m5gg7GXbZzODmKzCKhKNDb9BYuLCChLfGztZQdpZhbYzCwxY+4yF
  pCEsECIxK75L1hBbF4BI4nW/cdZIAapSSzcvYAVwjaR6OrrZ4SoEZQ4OfMJWA0z0LIr03YADe
  UAsqUllv/jAAlzCphKnD12Guw2CQEZid8rv4PdIAp0w7rFJ8HGsAGtWvrnJ/sERsFZSKbOQjJ
  1FsJUiLCWxI1/L5kwhLUlvj16zAZhm0q8PvqREcJWlJjS/ZB9ASPHKkaLpKLM9IyS3MTMHF1D
  AwNdQ0NjXSNdExO9xCrdRL3UUt3k1LySokSgpF5iebFecWVuck6KXl5qySZGYDylFDLp7GD8t
  DD9EKMkB5OSKO/DtrXRQnxJ+SmVGYnFGfFFpTmpxYcYZTg4lCR4RYHxKSRYlJqeWpGWmQOMbJ
  i0BAePkgivGEiat7ggMbc4Mx0idYpRUUqcVxYkIQCSyCjNg2uDJZNLjLJSwryMDAwMQjwFqUW
  5mSWo8q8YxTkYlYR519wDmsKTmVcCN/0V0GImoMUiB9aALC5JREhJNTDyrpp3+a+LWfwkrlNJ
  OdwxLtPVDrc6hyY/Wru0mscrVWt93+Y12bMP/tB1TjXLvtnEup5d/L/z7aQD286Jnshxfpa8c
  bmn+6G60DmfmHjnnhbot6w7Ze7B95/hT/T3eQeSVRdH3xNY/yNVsXbSSnuhSkZfe88Pprs/Ou
  qsf3D8UlSFJrfFslYlluKMREMt5qLiRAD8Tn2NIQMAAA==
X-Env-Sender: Alan.Robinson@ts.fujitsu.com
X-Msg-Ref: server-2.tower-226.messagelabs.com!1538121683!576439!1
X-Originating-IP: [62.60.8.148]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.14.24; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 15872 invoked from network); 28 Sep 2018 08:01:23 -0000
Received: from unknown (HELO mailhost1.uk.fujitsu.com) (62.60.8.148)
  by server-2.tower-226.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 28 Sep 2018 08:01:23 -0000
Received: from abgdgate50u.abg.fsc.net ([172.25.138.66])
        by mailhost1.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id w8S81Dsc025628;
        Fri, 28 Sep 2018 09:01:22 +0100
Received: from sanpedro.mch.fsc.net ([172.17.20.6])
  by abgdgate50u.abg.fsc.net with SMTP; 28 Sep 2018 10:01:13 +0200
Received: by sanpedro.mch.fsc.net (Postfix, from userid 5004)
        id 7A2349D00DA9; Fri, 28 Sep 2018 09:58:52 +0200 (CEST)
Date:   Fri, 28 Sep 2018 09:58:52 +0200
To:     Juergen Gross <jgross@suse.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>,
        "roger.pau@citrix.com" <roger.pau@citrix.com>
Subject: Re: [Xen-devel] [PATCH] xen/blkfront: correct purging of persistent
 grants
Message-ID: <20180928075852.GC6271@ts.fujitsu.com>
Reply-To: Alan.Robinson@ts.fujitsu.com
References: <20180928072827.14229-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
        micalg=sha-256; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20180928072827.14229-1-jgross@suse.com>
X-sent-by-me: robin@sanpedro
User-Agent: Mutt/1.9.3 (2018-01-21)
From:   Alan.Robinson@ts.fujitsu.com (Alan Robinson)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 28, 2018 at 09:28:27AM +0200, Juergen Gross wrote:
> Commit a46b53672b2c2e3770b38a4abf90d16364d2584b ("xen/blkfront: cleanup
> stale persistent grants") introduced a regression as purged persistent
> grants were not pu into the list of free grants again. Correct that.
s/pu /put /

Alan

--Y5rl02BVI9TCfPar
Content-Type: application/x-pkcs7-signature
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIIKTgYJKoZIhvcNAQcCoIIKPzCCCjsCAQExCzAJBgUrDgMCGgUAMAsGCSqGSIb3DQEHAaCC
CH8wggSjMIIDi6ADAgECAgo2C52zAAAAAlTDMA0GCSqGSIb3DQEBBQUAMC8xLTArBgNVBAMT
JEZ1aml0c3UgVGVjaG5vbG9neSBTb2x1dGlvbnMgVXNlciBDQTAeFw0xNzA1MTIxNTM0Mjda
Fw0xOTAzMTExMjI0NTlaMEAxFzAVBgNVBAMMDlJvYmluc29uLCBBbGFuMSUwIwYDVQQKDBxG
dWppdHN1IFRlY2hub2xvZ3kgU29sdXRpb25zMIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKB
gQClZEMpN68qHzred2QKqifLuUSlYnt/kB4V9Kjy8U7cQK/pN+ytbEBFXsllMyP2CjgGNYFu
oqeztgkla2vBrjV9ilrJe3s+RJqkXgioKG1RSuiDW0sBFvI90dS4mHCH7cOTPPFHO5QHuCBU
bClqAN0HlKweu/rIbqg0/g9j+SMb8QIDAQABo4ICMjCCAi4wCwYDVR0PBAQDAgWgMIGSBgNV
HREEgYowgYeBHGFsYW4ucm9iaW5zb25AdHMuZnVqaXRzdS5jb22BJmFsYW4ucm9iaW5zb25A
ZW1laWFjZW1lYS5mdWppdHN1LmxvY2FsgRxhbGFuLnJvYmluc29uQGNlbWFpbC5mc2MubmV0
gSFBbGFuLlJvYmluc29uQGZ1aml0c3Utc2llbWVucy5jb20wHQYDVR0OBBYEFIlosAD8kas+
gZn51OiifJoSRQTUMB8GA1UdIwQYMBaAFAj1yGq/gON7UMQ59AeYRuhtfpeoMDwGA1UdHwQ1
MDMwMaAvoC2GK2h0dHA6Ly9jZHAudHMuZnVqaXRzdS5jb20vY2RwL2Z0czAxdXNlci5jcmww
RwYIKwYBBQUHAQEEOzA5MDcGCCsGAQUFBzAChitodHRwOi8vYWlhLnRzLmZ1aml0c3UuY29t
L2FpYS9mdHMwMXVzZXIuY2VyMAwGA1UdEwEB/wQCMAAwPQYJKwYBBAGCNxUHBDAwLgYmKwYB
BAGCNxUIhYXEMoGH/2GBhYEEhuyCIIHHgRp5g4igcYfS8S8CAWQCAQgwEwYDVR0lBAwwCgYI
KwYBBQUHAwQwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDBEBgkqhkiG9w0BCQ8ENzA1
MA4GCCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAIAwBwYFKw4DAgcwCgYIKoZIhvcNAwcw
DQYJKoZIhvcNAQEFBQADggEBADwUZHvoZuxiGLFQCoURq/FgeKSyxKrjuoutb8Bs3blR2QDA
D3NWp0W+T4Js9fDcIb3Rq3uvFx0T/EcUiz1fFeQyN4B2xT8ofAnZeWuxWxWLUqS/K73fRIUC
m7DUNj8lgRGsnSnAIl6ZKHDrdvwnxrF7qFPRVz77B4k3BK5mkMxxNVtKjbCoPj8fnh17Vnob
Wnb0yztrPYeOHi2CqIey5qPjVMSTxKJYOejwjvE78SBMKKQS7cHBg+iOnYK90S0m+LK2/Yz5
vgJtjGJL+68d5i0O/rmzgefOEeuMtD0IOI9lFXoUS16hbxj8gMy0dXKxfPhoYWB7bqIlY4Ri
mpguPFwwggPUMIICvKADAgECAhA0zRJXyDaDRuC/9z0wA24FMA0GCSqGSIb3DQEBBQUAMC8x
LTArBgNVBAMTJEZ1aml0c3UgVGVjaG5vbG9neSBTb2x1dGlvbnMgUm9vdCBDQTAeFw0wOTAz
MTIxMjI0NTlaFw0xOTAzMTExMjI0NTlaMC8xLTArBgNVBAMTJEZ1aml0c3UgVGVjaG5vbG9n
eSBTb2x1dGlvbnMgVXNlciBDQTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALAb
TX9HzfBJFvcukKqEBkui1MHs3p1dgZw8zkXRmp7pEbaRs2DAD3cosLZadP8zjWvowiRs5F+I
mAo07Iib8dNUj0TWduHx2hRl6SQV+ffaumRdIrLvodWiGrNbX8ggWpQGyii7zYCLkI514XX3
1ZOL0rgcrTtzhnFC7SdvpWFUhL8cxrfYk0sE+UZxLyqUdIjgvvf1DVTojyvVws+bu24N4noT
+YA/r+brt2CEcFf+YMnewGT3HJE32D/xmXMm3AF3xJeZ2/22Ykix3mRI8TDDPGGahSoR/ccp
iHY5HESuzSdo/Dg+9PEBb+G+G5ntZhxn040m8W9ZzqFE7DbbIWcCAwEAAaOB6zCB6DAdBgNV
HQ4EFgQUCPXIar+A43tQxDn0B5hG6G1+l6gwCwYDVR0PBAQDAgGGMB8GA1UdIwQYMBaAFBR1
4le2FTcVgCqX5VFIZazPhpDLMBIGA1UdEwEB/wQIMAYBAf8CAQAwRwYIKwYBBQUHAQEEOzA5
MDcGCCsGAQUFBzAChitodHRwOi8vYWlhLnRzLmZ1aml0c3UuY29tL2FpYS9mdHMwMXJvb3Qu
Y2VyMDwGA1UdHwQ1MDMwMaAvoC2GK2h0dHA6Ly9jZHAudHMuZnVqaXRzdS5jb20vY2RwL2Z0
czAxcm9vdC5jcmwwDQYJKoZIhvcNAQEFBQADggEBAEO6UD/S8PW3J7dQ4b1eVFm9c5pwAkqO
p+sfm7qXJEM5a392iex0GYoGbmgmpPnXsS9fCPOojQwziQQbK89A3A+Fz7M3C01Hs6qhpQMi
G74gauZsAxwFgQPRddRkcei3axzCjXRz8AFsgt6+qr+BjugPs9eilGRUj+JL7mjeWByOPNU+
xRcRJp7ZMpaYZ3V/upkNTQAQKTDIV9GjeXVYTwDAD/JxDSdYRpPNSBvIM5KBwz0qCwrX3wJz
YWAKob6wztsm12//cfkn9w0LswYN4aQdciTNyvH6EGkt7k6RSE33TKa3EMqyHZeCcNurP+r6
SLNLIi1U6d8gMIDWqkEoMUkxggGXMIIBkwIBATA9MC8xLTArBgNVBAMTJEZ1aml0c3UgVGVj
aG5vbG9neSBTb2x1dGlvbnMgVXNlciBDQQIKNgudswAAAAJUwzAJBgUrDgMCGgUAoIGxMBgG
CSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE4MDkyODA3NTg1Mlow
IwYJKoZIhvcNAQkEMRYEFGaKtAFzZu9vnVRDeB9gNBRUgmHnMFIGCSqGSIb3DQEJDzFFMEMw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsOAwIHMA0G
CCqGSIb3DQMCAgEoMA0GCSqGSIb3DQEBAQUABIGAGIF5Z7uJhBa1KzaIw4hNUuzQpHTdy2pe
Ahk/mJsX4mPGi/CDu3gHQRElCRQ8X7jD2GkiHphP/km8Wojk85pZ0Opfr1ldVl46jrYkbYIb
CMC/AgOwTHeV3sT6o4IqabVvqqK0nPVIZRZ/GdEOnGp/kTAwg/bEdvYe9gzz1UzGlEU=

--Y5rl02BVI9TCfPar--
