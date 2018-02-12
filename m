Return-Path: <fbarrat@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x2252wbOntD1v7Sg0OpuFWJwMMtq5f9sQUokxgmd3ofF53jalvByK5r+HDmtDm8wfFNqeDOsD
ARC-Seal: i=1; a=rsa-sha256; t=1518429190; cv=none;
        d=google.com; s=arc-20160816;
        b=xKliML/UVG1VY1naJZZc//Wc6/EhVgqPlw7NXshCF/d8o6BNtS4U0+lmvxuOMmS2Tp
         PcdBog7um7aOePPp8LEvi9q/ZMXawnqAZQFAQdSe9SXWucwofu8vDiWuAjoQEPO+axEe
         gK4A7xbQUa/BTUjhZ3JBEznYh3tUnXg2jfK2PVfU9QNWzJmEODm2xxjf7uF1IwSK55xG
         ahvjm0dm+ZHL9nxT4glMQQdRfDb7yfNvWREcmjprHI5Lm6JWLgnBb+M/uSoPKppvtNHm
         oIM42sPVMA7LybH4VfGQec+QgnX7srH2t6eBORDun9+gBV40baSRt6Bba4t5GXCNuPF7
         M2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:to:subject
         :arc-authentication-results;
        bh=TdV1ZzCWL6T9htD2L+8QGJ9rSMpVUu0F4P+AKaKhlBc=;
        b=LrG05ruGKSqfpmB6POYhE3cWW3d3LeyCO3rRIHs6Yyare+zaZwSOe4ZLQX2aMnNAM3
         Urz2gDAMUIgAXoTtzr+ILn9nAFE2F+5BAtoFW1sUQNFz5bK3v7XAbvdD11PakWqHc8oN
         9nEI20wH8CqOZQWFRtAVmyvggYpc8flMdpqbm5yWqXD4URKxGz3Aa5FMJ+viFRjxr8u3
         kJPV+TtH2saW7SN52LZMSTVrYjSpBhsnhC9kQQfOwcGh5YMFguNK7qaG++OE9EYdwvAD
         hc49bXlhXtU2I8aAyesGkYyI0JzuFg0dgMr+P86BvTakN1ahEBjPSICIeiBxD3twolVQ
         xjlA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: linux-4.16-rc1/drivers/misc/ocxl/file.c:320:broken error checking
 ?
To: David Binderman <dcb314@hotmail.com>,
        "andrew.donnellan@au1.ibm.com" <andrew.donnellan@au1.ibm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <HE1PR0802MB23312F7C9FFE65D802F9D0259CF70@HE1PR0802MB2331.eurprd08.prod.outlook.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Mon, 12 Feb 2018 10:53:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0802MB23312F7C9FFE65D802F9D0259CF70@HE1PR0802MB2331.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18021209-0008-0000-0000-000004CBD4A5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021209-0009-0000-0000-00001E5F90FF
Message-Id: <6e051309-c236-7715-cffb-b53d2da600b3@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-12_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802120128
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592184949792413225?=
X-GMAIL-MSGID: =?utf-8?q?1592188406591499488?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 12/02/2018 à 09:58, David Binderman a écrit :
> Hello there,
> 
> 
> linux-4.16-rc1/drivers/misc/ocxl/file.c:320]: (style) Checking if 
> unsigned variable 'used' is less than zero.
> 
> Source code is
> 
> 
>         used = append_xsl_error(ctx, &header, buf + sizeof(header));
>          if (used < 0)
>              return used;
> 
> Suggest put return value from function into signed variable, sanity 
> check it,
> 
> then assign it to an unsigned variable.
> 
> 
> Also, use of the gcc compiler flag -Wtype-limits will show up this kind 
> of problem in future.

Thanks for reporting it. A patch to address it is working its way up and 
should land in the next rc release.

   Fred


> 
> Regards
> 
> 
> David Binderman
> 
> 
