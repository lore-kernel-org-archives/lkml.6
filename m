Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFDBC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DE820661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gzestmediasolutions-com.20150623.gappssmtp.com header.i=@gzestmediasolutions-com.20150623.gappssmtp.com header.b="vHvj0dD3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DE820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=gzestmediasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757359AbeFSU4G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:56:06 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:33825 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755479AbeFSU4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:56:05 -0400
Received: by mail-pl0-f66.google.com with SMTP id g20-v6so495954plq.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 13:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gzestmediasolutions-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:references:in-reply-to:subject:date:message-id:mime-version
         :thread-index:content-language;
        bh=DVPiqz6oI5Pq01BT8E4PQnaWjAwosS1G5/decGWWbc4=;
        b=vHvj0dD3bDKuc7Blohx/heOKMpakIwI05YHBPhf7DrtUCv+RyN7nZmwwbdNWan/9N3
         SIs7EQXu06qZ/yAFzx2FTYhiT3D3XicjgLJOrFERSzkYrrNcT1jRIKBMzXV+QPtihpI3
         3Zf6PDPYhx/36LpxB5FrsC8ggptr5V9jdG2FBkR73YW4CWZWC/gdEz/eQgDg55ySFjJ1
         zEflWuJ7Ly3hLubbd1FfBb7D3yi7AHPjh7EfXReyZ5m1rSWozh0o88bYd0KGlHsvHjh+
         9jL6GRQvp1Qiw3mBgUECvg+y5Dj47tgJFs1tTyVYnlqfhqirKrYVIQ/V9qEGHQfE3MgT
         FFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:references:in-reply-to:subject:date
         :message-id:mime-version:thread-index:content-language;
        bh=DVPiqz6oI5Pq01BT8E4PQnaWjAwosS1G5/decGWWbc4=;
        b=j0cvf/cjkYbONw4MR9A1h6DBKx+XIxGOS8V1awRfhcroMgCyP0+hYk+DlSA4LRLv5y
         B2ktU49oenQlDgk5688P2JPzB94/iSijXZmYfU0ZswyFHVduXl2VYFSrfUMe9R2FW503
         9Ck/HDw6mlN70QzCvvmGlcRfreaaCCPlIkpMZ3gesMCehYOnVADembQzYebrYTGMvEuu
         DjlUdFNcQuuy1F85/7gYKKsK+U1+bW9ves+IbDM/HI2fLUjrX9TGf5v+82eaIM0KrkjW
         UsocxJ04Q4IKsnvKnY0fPWIoWufX9+XVkjaYgc61JFpqfOe5jlMP8/sdHgiC/bH7qyOA
         YlEw==
X-Gm-Message-State: APt69E2gU327tCRVTKDUKJoKTCfwvA2hOpPkS8JolY8lSN+OYtXuxpdY
        HCfG4vaXIaK2b7XrMyFFJnzSIOi8Krs=
X-Google-Smtp-Source: ADUXVKKr4yzIdh+MOVlKMo/djf6y9tX9bAfoMWY/jG6TbFxGGCFPPAxvkfkpUP+1Ylk6Z2X57QI1ZA==
X-Received: by 2002:a17:902:1081:: with SMTP id c1-v6mr20512043pla.153.1529441764342;
        Tue, 19 Jun 2018 13:56:04 -0700 (PDT)
Received: from userPC ([122.178.241.168])
        by smtp.gmail.com with ESMTPSA id e81-v6sm902056pfb.62.2018.06.19.13.56.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Jun 2018 13:56:03 -0700 (PDT)
From:   "Grace Anna" <grace.anna@gzestmediasolutions.com>
To:     <linux-kernel@vger.kernel.org>
References: 
In-Reply-To: 
Subject: Flash Memory Summit
Date:   Tue, 19 Jun 2018 16:55:50 -0400
Message-ID: <209601d4080f$ef47f8b0$cdd7ea10$@gzestmediasolutions.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
        boundary="----=_NextPart_000_2097_01D407EE.683B3AB0"
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AdQID+QAzIZ9mRGbR7yx0VPD9LhuUA==
Content-Language: en-us
X-MS-TNEF-Correlator: 00000000171AC32B37D75A4ABBCF3E809E23988304962200
X-Antivirus: Avast (VPS 180619-4, 06/19/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_2097_01D407EE.683B3AB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

 

I have noticed that your company is exhibiting in Flash Memory Summit on AU=
G
07 - 09 2018.

 

Would you be interested in the complete (B2B) contact information with emai=
l
addresses of:

=A7  Hardware and software designers

=A7  Storage specialists

=A7  Consumer electronics designers

=A7  Data center/computer/network managers

=A7  Storage engineers

=A7  Communications engineers

=A7  Venture capitalists

=A7  Embedded system designers

=A7  Systems engineers

=A7  Engineering managers

=A7  Solution providers and consultants

=A7  VARs, OEMs, system integrators

=A7  Marketing and product managers

=A7  Market and financial analysts?

 

Let us know your target contacts that you would like to reach so that I wil=
l
get back to you with few samples and other details in my next email.

 


List contains - Company Name, Web Address/URL, Contact name (First name,
middle name and last name), Specialty, Postal address (street address, city=
,
state, zip code, and country), Phone, and Direct email address.

 

Let us know your interest so that we could help you with the samples along
with the pricing details in my next email.

 

Match Test for Appending: Just send us now 10 to 15 contacts in an Excel
sheet from your in-house database with missing email address, telephone
numbers, fax numbers or mailing addresses, we can append it for you at no
cost, this will help you check the quality of our services.

 

Kind regards,

Grace Anna | Marketing Associate

If you do not wish to receive future emails from us, please reply as "Leave=

Out".

 



---
This email has been checked for viruses by Avast antivirus software.
https://www.avast.com/antivirus

------=_NextPart_000_2097_01D407EE.683B3AB0
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="winmail.dat"

eJ8+IgMUAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQgABQAEAAAAAAAAAAAAAQkABAACAAAAAAAAAAEDkAYAEB8AADAA
AAALAAIAAQAAAAMAJgAAAAAACwApAAAAAAALACsAAAAAAAMALgAAAAAAHgBNAAEAAAABAAAAAAAA
AB4AcAABAAAAFAAAAEZsYXNoIE1lbW9yeSBTdW1taXQAAgFxAAEAAAAWAAAAAdQID+QAzIZ9mRGb
R7yx0VPD9LhuUAAACwAXDAAAAAALAAEOAAAAAAIBCg4BAAAAGAAAAAAAAAAXGsMrN9daSrvPPoCe
I5iDwoAAAAMAFA4BAAAAHgAoDgEAAABTAAAAMDAwMDAwNDgBZ3JhY2UuYW5uYUBnemVzdG1lZGlh
c29sdXRpb25zLmNvbQFncmFjZS5hbm5hQGd6ZXN0bWVkaWFzb2x1dGlvbnMuY29tICgxKQAAHgAp
DgEAAABTAAAAMDAwMDAwNDgBZ3JhY2UuYW5uYUBnemVzdG1lZGlhc29sdXRpb25zLmNvbQFncmFj
ZS5hbm5hQGd6ZXN0bWVkaWFzb2x1dGlvbnMuY29tICgxKQAAAwDeP69vAAADAPE/CQQAAAMAAlkA
ABYAAwAJWQIAAAADABOACCAGAAAAAADAAAAAAAAARgAAAAAQhQAAAAEAAAsAFYAIIAYAAAAAAMAA
AAAAAABGAAAAAAOFAAAAAAAAAwApgAggBgAAAAAAwAAAAAAAAEYAAAAAAYUAAAAAAAADAE6AAyAG
AAAAAADAAAAAAAAARgAAAAAQgQAAAAAAAAMAT4ADIAYAAAAAAMAAAAAAAABGAAAAABGBAAAAAAAA
CwBVgAMgBgAAAAAAwAAAAAAAAEYAAAAAJIEAAAAAAAAeAF2AAyAGAAAAAADAAAAAAAAARgAAAAAn
gQAAAQAAAAEAAAAAAAAACwBsgAMgBgAAAAAAwAAAAAAAAEYAAAAAJoEAAAAAAAALAHCACCAGAAAA
AADAAAAAAAAARgAAAAAGhQAAAAAAAAsAcoAIIAYAAAAAAMAAAAAAAABGAAAAAA6FAAAAAAAAAwB1
gAggBgAAAAAAwAAAAAAAAEYAAAAAGIUAAAAAAAADAHeACCAGAAAAAADAAAAAAAAARgAAAABChQAA
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
57kQ9zLLkHJ2kfCQsJPf/6fPq7/A/8IPru+v/7EPxc//sy+0P7VPyi/GH8cvyD/JT//n79s/qA+p
H6ov3J/vD96/f9/P4N/h7+L/5A/lH+Yrcv1jIGzsj/k/6Y/qn+uv/S9dEjBLktCPIFjwZ/igZP9f
cO3v7v/y7/P/9Q/2H/cv//g//h/6X/tv/H/9j7evuL8/EY//HwAvAT8QrwnQR3Lz5xBaQEFuWhAH
PwhPE+9/w/8b/xSPFZ8Wrxe/yl18Wb8hcmvOYJISQeZwb/9dIWAwBE8FXwZvGo8bnwmffwqvC78f
Xw3fDu8P9pDRafhnbj3N8I2yIOZgMJNQei0yUzoytCNPK2wT0HGeYxPfH/8hDyIbQTY60lw7beaw
OZA48i0zkmb92BEtPCM6bzt/PDLZoNJQ0mEh8DAwIiAlNK83JPZJVpCPkmSOQMwQjpFT0EeRcY5A
YsFlaXZaQGb8dXSNcFpAk4OQwM6Ty+D/WGCQkdASWPCQkFgAXEA3f6lVojIwVgwzi/phQwHeT0NA
Ra9GslX9NDbo2v//Jx8oLyk/Kk8rXyxvLX83P/8vnzCvD+8Q/ze/OM8h7yL//1kPTI9JL/Bv8X9N
707/UA//UR9SL1M/Yo9VX2NYzFBakRovwHB2Zg9qL2c1ONEd8m9keU1+Nx3xYcIFTXB9cZAAAAAD
AA00/T+lDgMADzT9P6UOAgEUNAEAAAAQAAAATklUQfm/uAEAqgA32W4AAAIBfwABAAAAMQAAADAw
MDAwMDAwMTcxQUMzMkIzN0Q3NUE0QUJCQ0YzRTgwOUUyMzk4ODMwNDk2MjIwMAAAAAADAAYQtIpu
NgMABxDIBAAAAwAQEAAAAAADABEQAQAAAB4ACBABAAAAZQAAAEhJLElIQVZFTk9USUNFRFRIQVRZ
T1VSQ09NUEFOWUlTRVhISUJJVElOR0lORkxBU0hNRU1PUllTVU1NSVRPTkFVRzA3LTA5MjAxOFdP
VUxEWU9VQkVJTlRFUkVTVEVESU5USEUAAAAAm/E=

------=_NextPart_000_2097_01D407EE.683B3AB0--

