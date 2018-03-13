Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AG47ELvu2eekciOFgzAcylH2SVzQfSNDaMErvngNk6hkYtPMLfoJwWNzCqO5QypxMZnz/I32J9E0
ARC-Seal: i=1; a=rsa-sha256; t=1520900794; cv=none;
        d=google.com; s=arc-20160816;
        b=sp9xxJ9Tll2PBi3vi9zwGq7hdDtU4HWXKX3rbJOz5UZJcDkEFgBJ2Uak3aYZkoyfsz
         hAFE28D0fxBVs0uGnS/ggSSXaK4UFYSoWroPm9uGYezb28SHURKmisiugs70lRAgvMdT
         0nnsq43RZUAYT/TwK9id6W3cYjsMO0MODaXY0s7Ok08fB5+zBWeGOVqEFVaTyZT5V1gy
         DlAnJRBk1+yERcRZzBEYzwIk0QNbYzIi++bXbmc9z80rRKG9aUkqmIe+Vk77RXnpzWzw
         1JLPD2sC7ZapAZuYtJK7BucCqeu8cDQYR6j4nWRLxt+D1HUkc5p93PFOMeSsoU4dyXDM
         7Umg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=ZgKLzytDz2LMAJjI88aCnDGsCbUUJ6kG4FsxWXKG0Qc=;
        b=YYZeLAsULOjsowPktQKDJkAUPxLm3X76h7crw+3dpVYP/nldXLClg58R5JGg3vVpcU
         S8r7is+MvizEYSRPJyutN+tLbdJffm/15e4jxk3vhhv1njVENFHhPaHiTpWVAmv146LB
         g7t2YCVVvNnfeuC4CMFPPQ6rlb886QgPCOwXU+KbQMqCqcfFOYAiAF7mZLQ/bD2Z2W/s
         0/lWe8kI8WTQjlnkjuCAjuKlE4r9D4+sXLrtFs3YjF8pb2oVEcr3OYK3QDtc0sdDZs5c
         TxqFTGi02i+aRw/iP66QtIzbFg9nWTt6fBP4UMQk3qVXz/Tzj9mUXTSvc962OUfQc+fc
         B6FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.156.1 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 2/2] misc: ocxl: use put_device() instead of
 device_unregister()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        fbarrat@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
 <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Tue, 13 Mar 2018 11:26:25 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18031300-0008-0000-0000-000004DBAF19
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031300-0009-0000-0000-00001E6EDF19
Message-Id: <c4f9c9c3-465a-8f95-ff62-4984d556cf20@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-12_14:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130004
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594731716562305768?=
X-GMAIL-MSGID: =?utf-8?q?1594780071640275576?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 12/03/18 22:36, Arvind Yadav wrote:
> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>

This looks right, thanks for picking it up.

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
