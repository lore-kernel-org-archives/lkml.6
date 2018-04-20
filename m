Return-Path: <michal.simek@xilinx.com>
X-Google-Smtp-Source: AIpwx4/dJOpZVtyKscTUdQU0MGk4jNszE9rRDmdpaAl+HzvBAOAs1bnou8ol3mIyEp20exeIfkxt
ARC-Seal: i=1; a=rsa-sha256; t=1524209040; cv=none;
        d=google.com; s=arc-20160816;
        b=F4d0JTBadVtvViFJuUTWLfpPSFMY5wn4EOQtTBNi6G86BfJbDBJFfj+zBfWHEyX0bb
         vPchJ6nfHFlPnOhNoGjzFBicOYXLPFaxk2NiAhzbXqA+/0IPNHrXPV65u1jTl+gc6g3W
         RbaHeYMQnbC9puyGZdsXx/HCQtcayM+/sh1j+fBfyJB4D5mz9sCCE985wxliNVSyFDI+
         yPY7vX9pooWBQk7xix9hHGcQtMJCK5JIvQcnwhmPiozSAdKjQ/nGdsGPUkXS87wxauB7
         W7PTl+tW9Vz4eJll6+zv2DNLPW8n47xyiP078YU7ThqmWT85N67kVAvNgU8DaLu9+Vp5
         kROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=wlI70pzpJQIj7nGGmDbFO8PRORCbY4avvWMmC4b+yyw=;
        b=oI4pwUjWWWBMFcgmcvUJSRS7kxb9G6S2LXhz/e7oV72L40U9w2Lc+GnwElLD8Q55Me
         2lCoZb3BgaECbZEx+b3Rlg6XvZi4Ur++UJju2Gi6nrg+EixS3c3RjZW2Cw559KcIi+AY
         XOifxc0cw8Q1kZXwtCDqY3P/pqtvZj3U1WBu863JASiZ2QTHb0dcRrQHWUB/y6mfM4Xl
         jbqhVjNdg661V8ZMD5ri22ncRk29JquNsNq2x7NElVprBfqZVt3MN0VK1oeo8ruIXNRt
         8U3rcSjMKi9K5t/yW/DObZxf0ZoBgF2VTAmSdh9Poy932sjTKnF54tIXghywJvUzrE1N
         7wLg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=qDHJg50r;
       spf=pass (google.com: domain of michal.simek@xilinx.com designates 104.47.32.64 as permitted sender) smtp.mailfrom=michal.simek@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=qDHJg50r;
       spf=pass (google.com: domain of michal.simek@xilinx.com designates 104.47.32.64 as permitted sender) smtp.mailfrom=michal.simek@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; sang-engineering.com; dkim=none (message not
 signed) header.d=none;sang-engineering.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 53/61] tty: serial: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	<linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
	<jslaby@suse.com>, Patrice Chotard <patrice.chotard@st.com>, Michal Simek
	<michal.simek@xilinx.com>, <linux-serial@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <ce3c4fa9-c6bc-a529-3c91-9f353d017720@xilinx.com>
Date: Fri, 20 Apr 2018 09:23:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-54-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39380400002)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(189003)(199004)(9170700003)(11346002)(53546011)(26005)(446003)(6246003)(126002)(9786002)(4326008)(229853002)(476003)(2616005)(305945005)(106466001)(486006)(36386004)(426003)(5660300001)(86362001)(31696002)(77096007)(76176011)(230700001)(54906003)(65956001)(31686004)(65806001)(47776003)(63266004)(478600001)(8936002)(336012)(6666003)(2906002)(44832011)(23676004)(65826007)(81166006)(110136005)(50466002)(316002)(106002)(58126008)(356003)(36756003)(64126003)(2486003)(8676002)(186003)(142923001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY1PR02MB1226;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT057;1:RlhwsOIUu5N/XpsX3Bzj4cJ7JNMzoLWJ6vIrGieOcPphN245eGrT/JY9CQQL4zkeLTKuZ4/4Q4lMn2P+5EFPTG9g0zW0NHHP3xBAvRvJIPNwfwXvPdx6JJyPrqS5Ttt1
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:BY1PR02MB1226;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1226;3:8VpSvsDsg4pNOTTn0S/ZGEC+6/RS8QjzmL4/rBHUk/QI5A89F9XcdOp/SWTaFsvwTueNyAfuc6o0P8P9LDMdNh2fnqe7OVF6kAVuABJn65lgdiN++fYCv1xdqXY19jEv++QiJp3Pz6ycHqpFXM/eiPYzfJr2HSWnAvwdXOMtQTbzct24x28mSOUnayY8R4vkZxpMmaxqO5rKZDAsi9GQgSEuzJCb+UZmcB1Xbf/p1v2LFv6zGsYetm4Z6ciYih7eUIAoIHokdnNMkZJzQEryTWjalgLFTAbSAD8sanB+Dgdmmj6IiVIHKA4tqImzvTcc7FjTmxy7cqo2isNuD8iAu3LQFiJp30fW0Ks7mYm2N9E=;25:9ew1MyN8HGDR2/gWflXKCx5kWwaM3/HLFu4vev1W5dWt339gYDXfR3WhdXu3aAGG+4CPoX7Kx6X8ok664KOZvTVjfhVE+eXuTcDAmUJK3Wi2G9PiHLLzGspUjv34yB7PGN1xZ3RwSGQhBlDDl42Rral6f4Y8DITFq+Mb97GIDCnD7f3BxXUe6BtXftbfOY7DGAGS76ooxviQQs65XwTSnwWJd8fY5vdGg+5/vcVrEamyQM00OGmevVjcedcWH7X9NE68Mq9DyiGs/K5bFLBP7VZpVbvaziwvfOa1J1eKr4RZfvawKQhu2mE+bbViWOn2308kDhCs4BOtmPKcoPgOCA==
X-MS-TrafficTypeDiagnostic: BY1PR02MB1226:
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1226;31:5tIhLGKkJr4ivf8ovjiDjbj5VdViyHRLWAqAJfElG5K6jA8j3dYMmW91e7frl9Yqz7bgivERsjNI2Yvj947ILNbbVKRB8Dse7+sZc1GcxgrCqg40VymttTYlZ9I1pew/EuF9xghzO2exlKLuLgV5prp/IFwJrN1paUcGtuCeUNoO9pbzMjPsPYaHQtg3/UaNHuCN4EHsUaYcfpmNihSV1L1gs2CjKdqno/RnDN6QpsA=;20:JwdOBdTvcYn+KW0avlHeebwrohT1kCGKf5trP7KoEzNpJP2ajIwVjd1Eh4flyMfajqGSZFBqgrxfWV3lKatRZBojyJzmMXChedPukHpSuoFlKLlGiRO44SzP8jPj0wxJ5jLmon9hsiaCgETglUAq6ss7tK7vtyVaGoz2hIsQjryJpGbJdWCqO7eQHp+yTT2ALKjC76DhUR2Ovb59LS7qKsOX15AiCwiB6YO8Ea02Je7ofGJHDg5usRP/LpKlD9g2Jk/gGc1KH8mY2x0CSwmXRerOj2zTWvKfG2P0TElbw8TNyPYzIbkuJadM58lhvRhSd7I2JO1u5KVVMpxOC5YHtjdHlZV7+t1w2smtR9uvqU1w7VGkz+9hODmBKYBHI+6m2bk224JLpGautyAxikWr9tBa+SqmLwp5cdzBduXP2JQlWP5A2xvfjleu1jz+ZqQpqumR3zjAE63HE32n2iD7Exd0b+ixb3Mvm8hopidK9KRF65h3A5DN+YCXHiqXL5Qc
X-Microsoft-Antispam-PRVS: <BY1PR02MB12265AB302CC4812C6B83F4EE2B40@BY1PR02MB1226.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231232)(944501391)(52105095)(10201501046)(93006095)(93004095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY1PR02MB1226;BCL:0;PCL:0;RULEID:;SRVR:BY1PR02MB1226;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1226;4:c8QVHINZwWMRsGOZMCkpSinKubvdh1gbqDvXN2Ti3uv+vkDGEVKysHn5DTunUtCg/kgWfQv5wwEOaO9PdjSP2X4YqAocDWlpLczdZIC3re3/dcHmHvaqYHBwQ7l8KQq4cZLP4lCTEd5azsdpOC17UCerHB3mZL7jIAxpRJbMamgACQ+qd/5Cmbc9ZZrpeV/k8icufFHCbSFXCSoIYsLHYUOZnkwP0n+JBTyiN6lt7siNogny0c4IZjbpUvd6uSF4TPiVwGVTKPIWDMBS72GVXZN2eiceVALWcGMy6jC+18TYUoyNJsKE+h+EVujmVSpJ
X-Forefront-PRVS: 0648FCFFA8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTFQUjAyTUIxMjI2OzIzOnBhSHlpeXdzd0JCczNlVzVNODFMTDZKTk1N?=
 =?utf-8?B?YjVPZkVzRFFXZjFRS0FTOHQveFpiU2tVM1A2eiswcmdDbHJXSFNURmFvblQx?=
 =?utf-8?B?aEZqMTB0c1N2anRndkVIdnFtQzVuKzlSZ1AzS0E3V1pQSG4vNnVhUWw1K29r?=
 =?utf-8?B?V01tNnJRNmpVNTBQVlBOaWFUVzdiMzdRRHpCZ0cxc2dFcTB0WHRDNGlVeUI3?=
 =?utf-8?B?aitIcnBFengrN29ramF3Z1RCZGo4Z2lENmd5cGtmSG9DRFRBTmxEMTcvT0Za?=
 =?utf-8?B?MmlOUGtuZ0tIT2pIU2JWNXk1bDlWSTVCbmxpY2h3VnJPb3FIVEFMeHI5VjFm?=
 =?utf-8?B?Y0hpRlRPOStFUC9VZkRjOGM4bE5rcE00bjU5djRERm5pK3gvcUJkdjhqWW5S?=
 =?utf-8?B?bzNrU2hycWFPVnFTZXZuT3kybUdQME5ZSy9WaGxtUWYyZFNldFVHWDVJOEJJ?=
 =?utf-8?B?eTZlYXh3WWJoSStiV3VZVHZHaHpEdVBjMFExME0ybVdZdFo0SDNEU3BrajdC?=
 =?utf-8?B?L1hFK0pRdVVHc3hSOHRZaU9MM0RiUUo5dmNndFBBcHJBWktkeCtybTI5Wnkz?=
 =?utf-8?B?QjY4WG93eFRrUVg3dGhuam5paEpoeVJ4R2JEUEc4ME1ZTnVQWnREbjBhdmc5?=
 =?utf-8?B?aTVsbmtCQUNVRWdScEpiaUQreTZyR0s1cjhPK05tTnExUldreFJvS29kSjZq?=
 =?utf-8?B?dktCYWpoMW02RTNBK2U4VWd3cE1YU1U2OXFzQUU2aktVdWxYbFVnaGVOOHIv?=
 =?utf-8?B?a2IwUmxxcWsyS0NmUFFXeVc2RnFnekZ1WWVaRXZsSFZqcGFpWGhmVUYwMEV4?=
 =?utf-8?B?TVZrVUJCSVdrVFkrTWtVeU9LQ2VjYVUwdG5MTmt6R1RKYThkN2FZa1RGY1Fq?=
 =?utf-8?B?UTl1Ym9GU2N5dU4rcU1WY1h3TDZhcFRFekNhRnJLUjB3dzlGWExDakZzVEdr?=
 =?utf-8?B?M2YzSEtGaVVXeEFhbWFDUDRxVWRsZEl0cVdUYXV5TVRJSDBDWVBMNlB0c1BD?=
 =?utf-8?B?SXBoOWlYOVM2dzRkODBBQVIwTG4wNC9CWkFnTC9kYUczNjJoZzhTci80Wldm?=
 =?utf-8?B?UkxKVjUvZDNNN0xJZDFFZmNBdEo1S2RUdXRiNjNONi9HMUhtSTF5MHFzYWRW?=
 =?utf-8?B?VnRtaE5mSHphWjRmMHVWMnBKbVBRYVUxV0dBajk0L3AzZDF1ajFGTG1SWGlm?=
 =?utf-8?B?UGRnSEV2RXpvQmFmaDh4OXlhYnJEQVlpYTI3aG5GUjVHSUhPSkNpZU1EZmM3?=
 =?utf-8?B?RnVIMXV5SWhDSXJ4ZVFPNkdtL1VBc2wxMGV1V0tKaS9maHhZdDNmeEpRVU5V?=
 =?utf-8?B?ZzdLRjdsaVU0ay93c0tZVlc3MTBtbGRFVjlOQVU3QVRpcEh3blE2OEdDVnpv?=
 =?utf-8?B?ZmcrVCs5UXp4bHA5OGxBcW1JTTNkTGcwRlhxcVl2Sk5QNnlzVi9qTWczWTdv?=
 =?utf-8?B?bW02cHYrdVdzNUpITENBdk02T2RENTk3cVl1OTNDZGdhTk0wN0d5SHhuUlJ6?=
 =?utf-8?B?bGtuWDdOMFU0bUIya2VFSVNTOVlmMEVNWG9Geno4QURJei9mdjR5TTR6UTZr?=
 =?utf-8?B?TDlxNkpHbVY0WndQa3pSbWpqRW56OVN1RThqMUlyeTBjMmIzanJabXRldVkx?=
 =?utf-8?B?b0dUa1VYTGR6TURLeDRsdzRsQTNFMzNRY2xvRks2eDQyd1F0YWNPTVdlZXFR?=
 =?utf-8?B?RXRONFB2SnBHOVpZRFV1emgwNWZ1bzlYNVBZamtoSU4vTFhrbUN3WWhjOVp0?=
 =?utf-8?B?cVRyZHdJWWVEd1R0Ylh1Vi9mNkJHMVZvYmJhamhwZEQvem5DMUJKZDMrRDlt?=
 =?utf-8?Q?FrWpfSq0nFm9V?=
X-Microsoft-Antispam-Message-Info: 6ROR6tv8UN6xIG2hnasQNofJA/KY6mri9iW7gIThh9wcE0jpcRyNBY3tAkrrLkuaFHyHmHvChtk4OXtQ7hefx6oqS4WkTDt/6HxAcX2fZ8SRf2iLxat5KF/Pvbco9iKuoR0VbZMYIKCq0AHQNOg3KUVy+okIzbiu3SCNElrxTvgLoZoxhes1UfRpX79Err6a
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1226;6:94+OU4vE6Y9F1Io8+/SeOxFiNPaVHeBc5FifuplmbnoNDYwtbIyO5VYr0jOQ48ik83dpcwGNO1ZiWt0YOjSGy74pI9WGcheaHrmY0GWTzWC4TK1gpo6nj+d0V0h4vOFIQRUWAtjm8WFtIPyxi8oR+3QSVyur0LCjeHa6QWgeaczTObPMKdIioDbEteTMnRvok6VZJDDYJNREmDXanP1o0JBG3xDljhUpbn/xUXG0yQDv8c0V/ly/QsiU2tCpR3L4IW58xlIlxlSE29jicxc/HjkyhDxcPVWRLudh3ngCqFtpqw2ncKRcATxTWYpno3qVPuKTz4vBTW4/VFowJB49XnwcIEHhCteWYMuwClYje12dg3aWy645bRfoBHbF2Tpq5gm3Svc0f9tfEXM9+v84su6pJDTG0lhdiFDAH5MIVzNwGzU5ydLsdn3MZOa9YpYeWGxBpwGK+INAE9zpUta6/A==;5:LjSUIT1y9Mga8Bkn74pI7w7DIjvaDjRlm5FZCYoMF8PX+eaUOJAVikN9RhzdS+TDaz/8l6UwbCONusCYP3j0SQ00QDkoYAVATifdsdYm+L5fT7/VHgw8YRm0ZkUDRIsV/fltnjHjoZp2WITDn9aFVw8PhkuMPg9TPVqfYUuCcDI=;24:4klUW2CuXA8qOzZqTVHbq1GXufoPTb3xDUPLtIyE9EggOo9aPAtDxyq186zPii4k5X5EjzPMsqDuyFA46AHHBUEMDqNnELwonAIhDZgX13I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR02MB1226;7:f+BC4LAg4v3HAfxtPX22f0hRZD+pgbgm3yz0fTNsfcyWQ6HmUx671gfviJN1IJlJgbOz5Nhpl/n/A4NPUXxl7Be0sFNo9R8VsiuhRm5eITNKVbJdFVv+Y9iAXB4heXran/gCTW4eDGqcvz277+afKOiGB3aJ+f3fymWe4dqwpY1oiPSeybDXN/q5a/KIVUKNOOsCSr2j7S3LndEcvziZkARtwj1HdtAF9X8TO5+oRtx34xq13EfEnra9cIKKDHiw
X-MS-Office365-Filtering-Correlation-Id: 20d54e99-09a4-4db5-7fd5-08d5a68fac2d
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:23:53.6677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d54e99-09a4-4db5-7fd5-08d5a68fac2d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB1226
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598183789276026297?=
X-GMAIL-MSGID: =?utf-8?q?1598249019029020623?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/tty/serial/imx.c              | 18 ++++++------------
>  drivers/tty/serial/qcom_geni_serial.c |  6 ++----
>  drivers/tty/serial/st-asc.c           |  6 ++----
>  drivers/tty/serial/xilinx_uartps.c    |  6 ++----

Acked-by: Michal Simek <michal.simek@xilinx.com> (for xilinx)

Thanks,
Michal
