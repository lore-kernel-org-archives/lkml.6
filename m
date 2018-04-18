Return-Path: <andrew.donnellan@au1.ibm.com>
X-Google-Smtp-Source: AIpwx49MDwj/9s2OuIgXgEjADVHB8tl6TtpdRnXnEyB0K/KpKjlga2QzwrQ+vwaESYAmFogrepUF
ARC-Seal: i=1; a=rsa-sha256; t=1524035643; cv=none;
        d=google.com; s=arc-20160816;
        b=H2hU8a8bEWzDFVjjGpyhPONbEgnth1JT366OgphmY6ed+i8aNgS+7IRmVyxNYHIBAg
         XMVAJZlDe+mS9b+DN5K0LBJDcqGUI/4i3VHqjgEBU19NzJCvPHNt2aQKZmlI92O8RIjY
         NvRLcKv/Nk4kK2QAlTag9y1lVNlTa57tTELRt8dfDGgfln4J/5YSuQv5F9bUjB0QDsvE
         lVSrOCGjtqOVAPtJ+C4WCzCzQnHeAw02xh8PU0qpNQF3RJimkR9l3ZU4fk+ImV1xMbVR
         cNJxqMAs2I0WGgF8jtAdYLqD4VenLDkHT4zQ1Jjsw+l/4DjymiYBjzw05Zda6zPszepz
         /3bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=tSPsGPiqnRaRjM8yV8HvbeCWWN7SBoWOq5YtW7tubM0=;
        b=zyXZq6j1TzOMHFkLyWNcnwJE3Uu3oKrplHcw3jCMeG371fF2xWiqc/GtvKQ3gkbSUX
         pI1g5zqXaxSXFkzIilcLJbX7upHqGiLripVcj6UWV3uCsrRo65IB6gHe3GTcAfM6D7AR
         TFNBFSaJBi+jQyC/wU5WC01ElDXNhG+vwyGMUQSEwkAi1RJSIQJ1m/KbOYuVQ1BzakvB
         xtwNDly06fFZXOW8TY0MK8qygU7b/MRKxjvyeC+7UMhuawbEw71T11fbRqIORBm9ov+V
         MxnVi4XvMcNRSrV75wKLaootVAlJ6uF0yGleIYgQD0zlpgINkkvwl4ZNkI7+sLiu6ZE7
         Yxhw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of andrew.donnellan@au1.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=andrew.donnellan@au1.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2 2/7] powerpc: Use TIDR CPU feature to control TIDR
 allocation
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
        vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
        sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de, fbarrat@linux.vnet.ibm.com,
        corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180418010810.30937-1-alastair@au1.ibm.com>
 <20180418010810.30937-3-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 18 Apr 2018 17:13:52 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418010810.30937-3-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18041807-0012-0000-0000-000005CC18E0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18041807-0013-0000-0000-000019486820
Message-Id: <e1383389-7739-3b6a-df4b-586f0caec5aa@au1.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-18_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804180067
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597957550458920157?=
X-GMAIL-MSGID: =?utf-8?q?1598067198353541668?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 18/04/18 11:08, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Switch the use of TIDR on it's CPU feature, rather than assuming it
> is available based on architecture.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
