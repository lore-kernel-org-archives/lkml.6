Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464F0ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D604C20883
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 15:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gxRbVT1F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D604C20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeIPUfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 16:35:01 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36350 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727394AbeIPUfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 16:35:01 -0400
Received: by mail-pg1-f193.google.com with SMTP id d1-v6so6489653pgo.3;
        Sun, 16 Sep 2018 08:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kqs9sdDK2NFgakmMfMKhwNMxUQ5HT0IxdkBONNK9Jug=;
        b=gxRbVT1F7VghGPDFfIyazQrKY1uGhES5nkcXxwp8XyHzzwdQD4z8Q/XFqreE5VqzU8
         6YQOrjTx44D5Huab+GBlj80RVD2JO8kqDbOSEuL4HG6fZoHA7SA5jw/trTgy6ei2iszd
         LacYJvCKv1oMUri3+4TylIbrdTviGyiZVHs5jv0ZAkd7hm8EI6wHO+qJJmBRPVBEZzdX
         tddPtXo63Xb5hb6nronpJlTGXmeWufrcg6vlmiSkHYHinb/Ube5Os82RbhPrhxbMTr+D
         N4zp3Sg10JRFNznM4+agHQnoACWKPeqLnJgqkTkB7gSOK57UOfyBdWL9j69xDV1kI5mE
         SGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=kqs9sdDK2NFgakmMfMKhwNMxUQ5HT0IxdkBONNK9Jug=;
        b=eUTY2Q8tHRxfRNeEOiRYpiEcjIkr56B2ueoKOo49DByiekbOvMAEpwK79wa1iHBv51
         /X+ns77OURFBMlo31WkUpHXHU7EEAQ9P8OJqQtZCx4J9LyEttZ4ZRgOje3jt3iVi5h6e
         dzNgepId6sRsTNiCweKR4qHs0LSCCeD/bWViDLd35m6MUW54C+VUySekYAiw/LzYzu2s
         2hVkQPtuOj9xPZXPgG1x6RupluXj1gG8G2NevAZFoQlWV0OUAoqo89BUacUXXFNrh1c3
         2T4/Zi+kiYC7WT4iAbxD42Ppl/UUieya5x1jv3vP6EF8pkoO8bhPdblh0UJyRvWr240D
         8dlg==
X-Gm-Message-State: APzg51BKL+XADfDxk3MGZ+cefwo7mGa3J9Q/Mww0io7AFanwoIQF+UsC
        vooOh2DUMy/4puDf/2prj1g=
X-Google-Smtp-Source: ANB0VdZNaV0nTPpkPerWMMjDoYt6i3xyqkGMfGsXxSaqUdF+pUSVlAr2Wx2DMgUoLHTWAU85yGsiLw==
X-Received: by 2002:a62:1544:: with SMTP id 65-v6mr21809889pfv.178.1537110705634;
        Sun, 16 Sep 2018 08:11:45 -0700 (PDT)
Received: from [192.168.1.5] (c-76-105-226-34.hsd1.or.comcast.net. [76.105.226.34])
        by smtp.gmail.com with ESMTPSA id h7-v6sm19714987pfd.155.2018.09.16.08.11.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 08:11:44 -0700 (PDT)
Subject: Re: [PATCH v6 0/2] tpm: add support for nonblocking operation
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153659990230.2284.5511495299744743989.stgit@tstruk-mobl1.jf.intel.com>
 <20180916120349.GB5040@linux.intel.com>
From:   Tadeusz Struk <tstruk@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tstruk@gmail.com; prefer-encrypt=mutual; keydata=
 xsDiBEiLICMRBADteQacQxypsuFvAw6IwYzbD8pgQi+kLYBcqfGgVAUN/cO+sLl6u1lVdaDB
 fhAArdbV9lpoqcWnmhQFTb4A+W569EpydBr6nuatWkEB+fmmx8YoUtuZfXt7v+1l1rc09kaW
 LY+TkwQkvFCeuvdasgmBLnmRWymEGWi1E12hUgTw/wCgtK24geC7XkiuANMv0gpr+raOgQMD
 /2yJZ0SeXQApWyTRaeIYN8GgYHZTWuBp/ofN+viEkhrDxahcaGPP5B/Nv6VS1+M0e5m8OzHj
 qPUbgfyOeJcslC5aoZdqqqzVWVLaA/+Jy+O+6T3k3R/IryVVATldBlwnGFDhET0mKQsd15zt
 cIdQBBbfSFR5VlugZuWV5q442IpPA/4g7nen9FFPxh45Te8D54hAsOCywjm6xUE0UJGYHeJ/
 MXCPtuXfVCbYcOxZVH7kUS2Vtk5d3bF40IE2WnVq1ZScNANF4ZjikxYhYGfNWX3HXak1gSoj
 UrY87rMSjPIAry4L0BoIx2qgL/k4iV/3QcXL4t5wosU0iw++suf1zGGcKM0gVGFkZXVzeiBT
 dHJ1ayA8dHN0cnVrQGdtYWlsLmNvbT7CYwQTEQIAIwIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheABQJQTjJTAhkBAAoJEDFswfskq9xyqvcAoI2nsaUCX8ZGbu+Jhq+++qlBFJ2rAJ983RoO
 R2ofHhn3g3Qi4K34tw0l087BTQRauzUlARAAqkWRL/InEPnoGMg/gw/CRaDBaIBgMsvIcghI
 7xevIzpleXt6jKHghSBooH+zaT7qi4u2gkgPn4odsER3Rm94XgrZJgoqls6EpKMWpJNGP4HT
 eYgykhfsZOLX8ijUbjTM/Sm/dZVo6aYoBL2+ciJwyl+Zt3Mp6un3/GWu6cA9005V50pRqO7j
 PTlVCHi2bedcEEf5DDsYJv/3Oz8/4LpSf6BL6BltjeZVa2y03dTMmD031JTH+OuyJm1yh72Z
 HWxhlYNXOv6uFJJVr+paQjrAsBVIYKhK24bD+uGJxLm8AN9i7/Si+2YeSsXvKUhk9mIoFBnU
 VFo63cziRTcpRu/kXgDAbujwN88qytEcvhEZHS6B9vdws+lhTpolEjkLCkz0Y59z4Fs9srKy
 QkRN+wtdiLgrwyDW3ryAKxcDmOumGWebDxpaOI/pBhrlS93HmDlvj7JmgTUU4a/NhwI3dXh5
 pn8FZzZyVXe3Kc3bu5T3UAC7uztinsAvCJQS6jGZWrXmXkqYkaLXQOw61eInWjr01zE/zDbE
 mdJPM0+va/gtZx9TtGxr4PpjbqswqCiubLDZXZHh5uqArPv/i+E8aXIsNSTN6Rrqs1j9YgDN
 ALksibv6+tXH3sOlCUgjuZgJH3+s/mnaAtiV2rZ/WlH15d6nd0uiDSZrKhlR+g4NHMh1ztEA
 EQEAAcJPBBgRAgAPBQJauzUlAhsMBQkJZgGAAAoJEDFswfskq9xyfv8An1osDQI/sA5cqrgj
 cvV2+TsxcukjAKCGFEQxLUxHDJs2KpQW2mJa5DGeCw==
Message-ID: <f86d6fe5-bafa-d392-5ed2-f5390b6b6e7e@gmail.com>
Date:   Sun, 16 Sep 2018 08:11:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180916120349.GB5040@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/18 5:03 AM, Jarkko Sakkinen wrote:
> I tried to test this but I get 404 from https://github.com/tstruk/tpm2-tss/tree/async

This has been already merged to tss upstream https://github.com/tpm2-software/tpm2-tss
To enable it you need to configure tss with --enable-tcti-device-async=yes
Thanks,
Tadeusz
