Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82724C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE16021570
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 08:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="bVeazEpz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE16021570
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeI0OS4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 10:18:56 -0400
Received: from mail-ve1eur01hn0201.outbound.protection.outlook.com ([104.47.1.201]:22834
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727049AbeI0OSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 10:18:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dMtTCPqBPYVpEr+phr2IWSFrMK2wRRMDSAH6jHmBZA=;
 b=bVeazEpzNbC43RY5v2YS//tITSqvPMrvrNI0WycB3K2Li8RJwZKRXCIIuZ01Dw8jPa0NLoxC0ag1/qb9hXJaoP2aXSzNLhYNMdGAD50XO9h4SGf6GFJ6VTNG5Ass0uld1VnXZwt8ePJxzhaetwZD0dtTdOArfQWEJGlqd3+t5kY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com; 
Received: from rkaganb.sw.ru (185.231.240.5) by
 AM6PR08MB3590.eurprd08.prod.outlook.com (2603:10a6:20b:4b::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Thu, 27 Sep 2018 08:01:45 +0000
Date:   Thu, 27 Sep 2018 11:01:42 +0300
From:   Roman Kagan <rkagan@virtuozzo.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>,
        Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/7] KVM: x86: hyperv: valid_bank_mask should be 'u64'
Message-ID: <20180927080141.GC4186@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Wanpeng Li <wanpeng.li@hotmail.com>, linux-kernel@vger.kernel.org
References: <20180926170259.29796-1-vkuznets@redhat.com>
 <20180926170259.29796-6-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926170259.29796-6-vkuznets@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Originating-IP: [185.231.240.5]
X-ClientProxiedBy: VI1PR0501CA0028.eurprd05.prod.outlook.com
 (2603:10a6:800:60::14) To AM6PR08MB3590.eurprd08.prod.outlook.com
 (2603:10a6:20b:4b::31)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 136110b3-7180-4a5c-7b40-08d6244f78e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3590;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3590;3:eQfdBoK4RsRsGjXkIHnfR7xFS10fU5lKEoJno0a8ZTQwkWtZW9Maio5xVUVBmsd+JtsfHGVMpPRzWMziFHhN2Ol2zjg/z3nMnJmS1MfxgBTh4jkv7UBX3fKcjHUMa6hYUiQr8oGV7Uozo5o1yQu/S3qdQHs4s/TZLp+G/9gobPm6ivOQ1Jo3dtWQXe8dWk3xZDvq+4QSUMYPee7ho7Xumija3Y9kRNw8PAORAUlOMqw416/wrZGEVJu0SDj2EzsY;25:131cacUQNKb3/4ApoatA9kbiLbMTNn4dmO06Bcy77C7yuFVsZZKzjDDPgCAthUvoOwLHSurdolpYD7mJQDGKboqVEbkkZva7Q/InPuvCjmzO0LK8gpGK0ftnX7F5HC+Yd6mecBXPcvaYLhlQ/VzyrjLcWbpnUGJVDzjuHoHPIwIlVotrpvW1vlagZoUV8Ei/c3gMaOstxt6SahOVAIvkkTkFcNzeyz+5oDJdNNfOj8V2N73cRulajnoJav2LGUBMystabIZ1+JUe9PXJ5ucW4EGx+eHn07hNkp7e14kMrYP/vwI1EaXhmOxwTLtf3EkeOGWxYFcl6zy/6SbXYp2uHw==;31:1K5JNtZ3KvD46O4Dw2hOMoDl1qARIdH8tGzv6lusd8ven3mqYy7igEWTAmt8GhwOFGYOutNTgRKRf/TZ4urIa0/DKvnvTe/nPBhlFKTHtUlCwSUJnPVoidSOZmDqMwJBO+X8EB/o/7SGOsche4uYR8gw46Yoqg9vUyXCLzxP3nkidZiBI3zrrxHTV3PtEeKxzaDhZWkRIR0q+nIvb8vtiugZgV9MvRb8oHVPxMPYXwo=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3590:|AM6PR08MB3590:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3590;20:8il18O1Q5vWUDkRRic0fbCo9i11ItI7L/DOdgN43mXfiDCRkdCiYk9o9vv6ybdL9S8R/d2QTdwvxWk6nZbbPwqJlMmzw5EIf+ymcjoYL+WRv1nMQZ9WjF3pYIqmizastyj1bE7vxZ9RfiQ3yTG205BVy2h676BitEEevEJKb7NWONeLUj5OSKIAxFt4D0K4zMMhQTjwNF7X6s0zJQH2BMusoUkz3AdfE/W32N514SpD4mjj+2Aay3lAfOWPL8q6mY8n+IRh+tpGy05vk9+wJiUj9KAWD757ut0iJgNL0TDQLSsUGh++dQTBjOIGlhBE1p5tNygY4NUnETYgw5KkeNpXGobtc57L3UKwXSJDJzSeZQCsno0kjyp7R+ZhU7bGqYA/PyAMoIi1/0A1e+tZoVazX68aifQzlmXAnA2FIOC5XhRjNkiD1TYOCQ2TSqQU9xLRG4ZWqKrq9PbX1lm9LQks8yXwIwwzAvfLAFKYLOSqyfGJI+YesSewi7LhDfhC7;4:6ceRO79gKYYcmVa0KikWyAk2UQoaKanH5bnipb1SXOaZgXtR+9pK6hxZoTViJgOr2uoTaJ325O45jh9/h7dR5FRsHhAIhwA/ITJ0Tv49iR/Qgkuvs9MpebZBGGXpxHnAPUlPo2wTqbDDXXzJgao0PCKKfFLs+w0J/rwSwETw2VSz6Sq85UVQc+eDOnQkPjYgTiJn2eV+aby2GZ8HPJ6Rr3Qh5DMFSDVfZBztpqj9gx945l0/5R9IMyAWYBbjX39zMv6kMCoeFIrWuCn+1VwVfg==
X-Microsoft-Antispam-PRVS: <AM6PR08MB359075BAEFB104B6DB74733CC9140@AM6PR08MB3590.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:AM6PR08MB3590;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3590;
X-Forefront-PRVS: 0808323E97
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(396003)(136003)(376002)(366004)(39850400004)(346002)(199004)(189003)(16526019)(7416002)(16586007)(186003)(316002)(26005)(55016002)(54906003)(86362001)(229853002)(58126008)(23726003)(66066001)(2906002)(47776003)(36756003)(3846002)(305945005)(7736002)(33656002)(5660300001)(6116002)(76176011)(7696005)(52116002)(386003)(6506007)(6916009)(6666003)(478600001)(50466002)(97736004)(106356001)(1076002)(69596002)(8676002)(68736007)(81156014)(81166006)(446003)(11346002)(476003)(53416004)(4326008)(956004)(9686003)(25786009)(105586002)(486006)(6246003)(34290500001)(8936002)(39060400002)(53936002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:AM6PR08MB3590;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM6PR08MB3590;23:oaafmySiNqrVzsD2OK25f+uvWhWCi9gyXe5Zog/X+?=
 =?us-ascii?Q?eP7ewdfdbVO0VKHqncDy/d6QOYXS3mQ+3Shatosc0pEwozC8OmtCZUL9kSAu?=
 =?us-ascii?Q?MZ9Cs7DOCreaw2yt/kwoHCLHm1LEpenLrSh2J4Vt734j8N8jOsjolnZO0txU?=
 =?us-ascii?Q?hBCeNsiqMK3X1n21M1IlnfCDjuvDAwGvnDAp7U7ebgBjbjv7+gnNpyXNW8LH?=
 =?us-ascii?Q?+SI6l4G/zX70Tgt14cRP9sEQBB/LcS2lcVjoTS4PkNgwDGP6WftdO/H3n6h/?=
 =?us-ascii?Q?MLi2yUw1ATIwSILpRndX39wf1UoCv2KNhIKPCzOQQeSWypeAqE9VS9yNyRsS?=
 =?us-ascii?Q?sIDr/OZ6iTOkm3WydutfuoGb6Y5JEb40MQoiUzI+H7lLtBqSUhPdZTawXJ15?=
 =?us-ascii?Q?uKsuCUhwdE3f7Lvq1eGVC2pIxULl98wv+hQOrsWnIDuG7JSsi1pO7waie39B?=
 =?us-ascii?Q?uoIInM4QWoMkkzF8B9wIvkkACcRVhLqUsK1Hijw+66crrG4kgiNzhAZQcOf7?=
 =?us-ascii?Q?fb7n4jt1ArZq4/ibOzaFu7jMQyOAJl+mp4z9MSU9MEw9XRUEIRX0GFEmBkPq?=
 =?us-ascii?Q?V4LI8m4EIlV3EdE9cm9qr2VsFIFK1ygqV+DUtMbkCsYdNfL2zh07AlWoUHKz?=
 =?us-ascii?Q?1mFI5dZvIoycJbqrzf/C3x4KODL9AzXKXpxTVHUClONXuZQ+QEs+fMiWfRg4?=
 =?us-ascii?Q?ugJmgLeL9owubW7WVjYnZ4pNUFIKglkASNwdHUZXQ9uja9n8luw+XOXFR1jf?=
 =?us-ascii?Q?jEFtNK08zcB83dgEhqqfyMwE2GI04s7sgdb9tqiN0D6kEUHO4+VVYu9yD0uw?=
 =?us-ascii?Q?Kk6z5lKxlPKqIoIwmj1fGW5NZ6UEnQEvoFLViAwvaxPDXDTnrVBM6jLSqcKz?=
 =?us-ascii?Q?6FhD/ZRUNerxItMBRAiqKnREfwSLIoIUVPVUoaoZjzAzVckGUdQ8ixy9FDlz?=
 =?us-ascii?Q?JP+kSsP+mAW4B5AWLMAgz5eu6/XhVZzd0mNOMBjnrzHfUAycm0nE6nN8AW7O?=
 =?us-ascii?Q?GnRZdI/uQc3Y2hlOer/CiCfxjmkNKA0HNiv1pFSkrVe4QDybdsZ9LXp0/0hn?=
 =?us-ascii?Q?wxRBARRw6JGzemzvdMb2YEysFO1a8i+KLnP9wL1o+/l0zBUQlCB/YgDIhKUC?=
 =?us-ascii?Q?3UAYYJWvct5f1lP3Yw2jfNkIkr6AVt8iR6rx1NsZrBMaZfVdY1UZO631bN1O?=
 =?us-ascii?Q?XHTCjs54fhR6E6J9QZsGOy/Dh4+tRODKJOF7sN4GfLxd76mbeMva0i+YwE6S?=
 =?us-ascii?Q?3KR1ynNjlQ/CgTAIeW5Eyv/ae7oIGVBX2BKk634mOzATCsokZJugdWU9XnRa?=
 =?us-ascii?Q?lJrjWgu74/FSePcxvFku8n4VJnd7NTPiC3e2QHS0jnfNJ2Yd8jovUN5NNbNP?=
 =?us-ascii?Q?J6zSJtqrXe10NQu1M0zJiBRLpPcdF4dgWXI9PTnUVJ1y4EegdaR+2NaYCyii?=
 =?us-ascii?Q?41aY1XHTg=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3590;23:ZL8SH6XftZfn96Jix8/5OE6fUiTjvx2fLpnWckTyd+bM+xZUjZ4f5T7WMFRfs7mzV/hAfPx+3K4IbD9bA3ZVpFoK4IpDywLk88eTBoqlSCSYwILzKOaHQaR3aFo62pxN9AqrwF/J90UPhmcpRWERBQ==;6:SJfSIBSZCLAKM5WQpdQ7a+qamyJ8dVQtN7QR5HD+z4jXbcKbCTpuYmg/4t6f6M+kVcyxJS4voCu32zGfKtvuqCUm7nnB0QJPD+IEFuIDXqvBOuTGfa3sG36bpcSVnlLxSQT8FeGozCX5XCbGQfvsr/YEhoIrgUnNis++DG1x8w6zdpmjDgLAoapwsvRZciotamtlDTiK/SA5bBTL8tGZ9zt7EKAbNmPix5/O1LqOhnngu7/lZ18byv1O1tqjxDf/xuvexVVjBiRsDqZ4MmvJc0j6CKD1gC2oFMoE/W6rrzWGdPom+ZfHiX6SIaExYCFJGyWlvcZNLiogo6i/uyidB8+TSkWiyWk4DLA6l0mP8WGIWUY7u64ViM6gPcf4IQymERfIHdHyo407kqH6AiDPzjJCJEEmzpkwhZ7fSmCPzUby4DZM68/1TEfIGmfOuYtBqZuTJTWjwH7kUatv+vHFphdPSFF2B48rbNM/l74+5het41lkU4A9a63tgKYJIOX6;5:0rMZrEiIQ5UVB/v3xLx/F9J4uSK/Yz7h1ayxNlZnjy+yA+pGeUOy1sE4nh51FgP2NkDQdFTQp9d80sa/KNLoxljlsvVL7fpOfPKton6EJ1oCQGhlaS7gomVdkgtF9t8fqX+kiQru2PbxVtnmGUpdANGotcPoVBdQpzeUWSNip9E=
X-Microsoft-Antispam-Message-Info: zbXc7fkDt6drKbi2XBF/j4GdkNmyrQVo5HfwID8cZW2vUiFOab9DZMWOLb2TXPDxEZpuGQPORq+Asi/LI+yKi2RXZMzilha/dJedsUWNKN9GHC9sjZrF+s8EkJmq31v92xBd9ncDZ+UmkN5J+tssyn1ZIdMaEgeKcNSppPeLExGJz/XphFY2ka43vwfnS1ACIJohGX832khpyiak93xoTNPXxqw0Rc2KgedavZFFIIgz1qlkyc00KG75bdkLrgNwjIHu2Upp/UqmlOHqP7CmIkGo6yorzKTICLh6IM/YxJTq+mMwpAQH3dMRc3/xBd7SteEFXL63PO5J2pJH+D7KFRysPJ6pIPnhUYBvqM/+Ka6ze1iVlJRQkj6AmBExvO7051n7GLvsfca7nK8Msq264f2yf0KPLLPMSG3P6FqWAbOCfLDUl2UWXN9fmSCPr5eBcr90qqSzBt6JmkeXtJ4s7FYwgIutnVEF+U87bJmydCtqryp/28sFSWGhBD6GHlq9IKuN1Zbc6KXmicekrp/++7WiB/Fr0QUqaziah7AjF33KDWgJJT/qordbguNImcnjltxckRMsrfU0pjjfBB4XrQ==
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3590;7:q0QIH+2VLzt7s1HkT6hj9W04IaYl9IX8tKqDh1EvUU5HtncTHvotFjo3gUQu1mtQu43YeMyVVHk9giK50E4QWZKBXvN4S20o6D+GQdc2xahfqH76M5YLLqmXKKtrDPCsXcCTQXoFSVyCwZznn54K3HG3/RgWZ7C7sp7oEEDHkKa0pojAN/YM8dyVVo4a2WgqhhWLHolH+TXX++zkf6XxP9hKJMFxpaLUqsQGmMmBFHsNNdbm+wXfO+NViseKt14E;20:dIQqyi2jqlWMOmeds93JLI992+LfQzMlGPB6vyWgc00IZYGNC8r/WZsYXWSxss7/eHYNvIUzPl6LxDTVOfC5yZMrdQlbA01Owh1Jstf0nBtW5oCcvhUyW8uB0vUmDiCxlcpO06RHmOyFiFXP8RsU+S1G/E2nMlaa9gzR+H6fhzI=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2018 08:01:45.7120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 136110b3-7180-4a5c-7b40-08d6244f78e2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3590
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 07:02:57PM +0200, Vitaly Kuznetsov wrote:
> This probably doesn't matter much (KVM_MAX_VCPUS is much lower nowadays)
> but valid_bank_mask is really u64 and not unsigned long.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/hyperv.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
