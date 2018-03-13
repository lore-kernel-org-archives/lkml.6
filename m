Return-Path: <fbarrat@linux.vnet.ibm.com>
X-Google-Smtp-Source: AG47ELsf+8gRdSMMpyImfSqMZAf7oqWLMP6Iruq66Y4f0Scel2obBQCPejHfaxLfwBMRmJxuHy2R
ARC-Seal: i=1; a=rsa-sha256; t=1520933916; cv=none;
        d=google.com; s=arc-20160816;
        b=BkucdmQzEiINGbpvU4/YSQDhg61g+CWi1Kws8aTG8LVt0emCV8Sua/rEhGpNP+XToe
         5jjj9ZAy4wj0IpbKCTTo93H4zaEkQQhSB/D4tVkp2PgvY/QQtRuv1pK0AYeR4bj3EqTa
         c5EeQ9jI8Vj27QYnpMQKM774MNH4t6V4EqpdaDVzA+FbOlvtvZ62J7d+37nChxtovuQj
         bEROMh8AhicONLpLFIfEYLQnMOr45MwzDLBbv+5Wd0SpxxeGx8fM6lJ48m0KDb433DDv
         TbdekRU/CgsdP9wMHApY7MLNA7o7LRPyTo231LY6cmhy7myUXA6RzYxBUEISPv8OlBKe
         piRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=NWFTxcmWodLH2MRTjj6cTEfxLq/YzfAhNT3OQUukdsQ=;
        b=cPPaEEV38KR6SnCM4At0VoZMsiQ25EsslwlNju+oqRRNJpxReMYlBx9UvlMQet7XB7
         rDaz21n+av7gIXepBytoWtZ1wBOF0VBXiYIynAOiC4C87mUBnZB0eJBXlrVYPa3/1B4w
         51HagGmMFQFZbnS7X2msMwq+q9nclenVSozxO88Sh5NJMdhPbjv2ra6tgP58tS0nd2Em
         C0juZjZ9BLxCMlwXAbXLUEvHjmnS91EI2euLeueuqkjAzoqV6TMRiHHh3V9QsSkiujvZ
         /12JPFl3LqCx91wG5qVyz33OGSn8G06RgixLaQ4cNdxRBmgxkDfoaXM7Xj54QvUTpCxC
         +kkw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.158.5 is neither permitted nor denied by best guess record for domain of fbarrat@linux.vnet.ibm.com) smtp.mailfrom=fbarrat@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH 2/2] misc: ocxl: use put_device() instead of
 device_unregister()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        andrew.donnellan@au1.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1520849284.git.arvind.yadav.cs@gmail.com>
 <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Tue, 13 Mar 2018 10:38:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8c4d28703e408b71284af68d07c117e7b8c8a75a.1520849284.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18031309-0040-0000-0000-0000041EEA54
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031309-0041-0000-0000-000026221428
Message-Id: <c1b768e0-c5d6-a0bf-f756-6f7bff159bea@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803130117
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594731716562305768?=
X-GMAIL-MSGID: =?utf-8?q?1594814801890541309?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 12/03/2018 à 12:36, Arvind Yadav a écrit :
> if device_register() returned an error! Always use put_device()
> to give up the reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---

OK, device_unregister() calls put_device() but also other actions that 
we can skip in this case.

Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>


>   drivers/misc/ocxl/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/ocxl/pci.c b/drivers/misc/ocxl/pci.c
> index 0051d9e..21f4254 100644
> --- a/drivers/misc/ocxl/pci.c
> +++ b/drivers/misc/ocxl/pci.c
> @@ -519,7 +519,7 @@ static struct ocxl_fn *init_function(struct pci_dev *dev)
>   	rc = device_register(&fn->dev);
>   	if (rc) {
>   		deconfigure_function(fn);
> -		device_unregister(&fn->dev);
> +		put_device(&fn->dev);
>   		return ERR_PTR(rc);
>   	}
>   	return fn;
> 
