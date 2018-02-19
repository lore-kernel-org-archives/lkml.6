Return-Path: <khandual@linux.vnet.ibm.com>
X-Google-Smtp-Source: AH8x226nc6/rZpE0QXmS55MH6rfRXslfjpBHAPFRLzwuLx4EVeWjVbf+tZsiFsKwlEgGDokL/SnI
ARC-Seal: i=1; a=rsa-sha256; t=1519013561; cv=none;
        d=google.com; s=arc-20160816;
        b=YIHJGhy0qTRx1sm0PTK1ApIk7oP0OqwUxKVk+rt2xTu5kO9XVF4CXOc5MXU3pRpT2Q
         fUyxiIxparYIUewtI8XT9j8ajkREJ33ERY+7iUO5uVtQ/RRKZoqilVysYJaJFIXbOvEM
         BL7rCu0KOA6CNfZvrQkvD0Yvd4+8GEVUHJMT3giz/kln+adKjpok5XDJegdnrzGDUrlP
         PruCUsEJm0FUmMOhSv/usD199HJgFb+YJ46ArAD5CZcOyX+XEWau8W3n+LJ24tElutVn
         w/C6lNG/ZGAnyvZmQJqfbiHpcmWJWK7mn8UL9+EvUsoQIEWveYsvtmcm279KhM/cKlX6
         nN6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:from:cc:references:to:subject
         :arc-authentication-results;
        bh=14QtiIYJbDtMatjqrhTXOncphBO6enxA+/rbb4kV2CU=;
        b=S7hQFczx/8el2CLO6HRvFs7U2LqEVuMimwuWs5L+ueEmZYoJt64D2/6GSbblv3K8f4
         oXtUR1r/mF8PKJrVOKfRh5QOLSe5R6GAVjEl7elYrKp02CuJlQhNlrHjClQqNjk+h9bd
         lfjMUVN626FvC57OZkvhcsZTk2e+kcIovmcReL2qezLzUVK4QuaI6VQbbyGcjEdV2lDs
         xK+OvtrgJeZ28zXPdmjyT5/NotvL5McuxbNBKNv3lUVbSAGGKJuDLtFUzkF8MGt3Jl75
         Qoz5pxy+479IYd0EmFJqHepRTBplTBbZ8TBGVL1FKiY7UMfC/qta6LMqV4gV94kDBkqR
         ywng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 148.163.156.1 is neither permitted nor denied by best guess record for domain of khandual@linux.vnet.ibm.com) smtp.mailfrom=khandual@linux.vnet.ibm.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH V2] lib/scatterlist: Add SG_CHAIN and SG_END macros for
 LSB encodings
To: kbuild test robot <lkp@intel.com>
References: <20180215033356.6978-1-khandual@linux.vnet.ibm.com>
 <201802180359.yuetSevh%fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, bart.vanassche@wdc.com, jthumshirn@suse.de,
        axboe@kernel.dk, chris@chris-wilson.co.uk, tvrtko.ursulin@intel.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 09:42:29 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <201802180359.yuetSevh%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18021904-0008-0000-0000-000004D10DBD
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18021904-0009-0000-0000-00001E641742
Message-Id: <c407c32f-a7b6-06c5-4a03-109445e27427@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802190051
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592436393983047782?=
X-GMAIL-MSGID: =?utf-8?q?1592801163663988509?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/18/2018 12:58 AM, kbuild test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on linus/master]
> [also build test WARNING on v4.16-rc1 next-20180216]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> 
> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/lib-scatterlist-Add-SG_CHAIN-and-SG_END-macros-for-LSB-encodings/20180218-015554
> config: x86_64-randconfig-s3-02180201 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=x86_64 
> 
> All warnings (new ones prefixed by >>):
> 
>    In file included from drivers/staging/rts5208/rtsx.h:180:0,
>                     from drivers/staging/rts5208/rtsx.c:28:
>>> drivers/staging/rts5208/rtsx_chip.h:343:0: warning: "SG_END" redefined
>     #define SG_END   0x02
>     
>    In file included from include/linux/blkdev.h:28:0,
>                     from drivers/staging/rts5208/rtsx.c:23:
>    include/linux/scatterlist.h:69:0: note: this is the location of the previous definition
>     #define SG_END  0x02UL
>     
> 
> vim +/SG_END +343 drivers/staging/rts5208/rtsx_chip.h

SG_END is already defined in a driver. Hence shall we change back
'SG_END' definition as 'SG_EMARK' or any other suggestions ?
